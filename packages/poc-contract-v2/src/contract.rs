#[cfg(not(feature = "library"))]
use cosmwasm_std::entry_point;
use cosmwasm_std::{Binary, Deps, DepsMut, Env, MessageInfo, Response, StdResult, to_json_binary, Empty};
use cw2::set_contract_version;
// use cw2::set_contract_version;
use cw2::get_contract_version;
use cw721_base::msg;
use crate::msg::GetVersionResponse;
use crate::error::ContractError;
use crate::migrations;
use crate::msg::{ExecuteMsg, InstantiateMsg, PocSudoMsg, QueryMsg, GetStateSizeResponse, GetStateKeysResponse, MigrateMsg, GetMigrationMsgResponse};
use crate::state::STATE;
use sha3::{Digest, Keccak256};

// version info
pub const CONTRACT_NAME: &str = "crates.io:migration-poc";
pub const CONTRACT_VERSION: &str = env!("CARGO_PKG_VERSION");

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn instantiate(
    deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    _msg: InstantiateMsg,
) -> Result<Response, ContractError> {
    set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;

    Ok(Response::new().add_attribute("method", "instantiate"))


}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn execute(
    deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    msg: ExecuteMsg,
) -> Result<Response, ContractError> {
    match msg {
        ExecuteMsg::PostResults { results } => {
            for input in results {
                let hash = hash_string(input.clone());
                STATE.save(deps.storage, hash, &input)?;

            }
            Ok(Response::new().add_attribute("method", "post_result"))
        },
    //     ExecuteMsg::Migrate(msg) => match msg {
    //         MigrateV1ToV2::MigrateSate {
    //         } => migrations::v3_0_0::migrate(deps),
    //     },
    }
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn query(deps: Deps, _env: Env, msg: QueryMsg) -> StdResult<Binary> {
    match msg {
    QueryMsg::GetStateSize {  } => {
        let size = STATE.keys(deps.storage, None, None, cosmwasm_std::Order::Ascending).count();
        let res = GetStateSizeResponse{size};
        Ok(to_json_binary(&res).unwrap())
    },
    QueryMsg::GetStateKeys {  } => {
        let keys = STATE.keys(deps.storage, None, None, cosmwasm_std::Order::Ascending).collect::<Result<Vec<String>, _>>()?;
        let res: GetStateKeysResponse = GetStateKeysResponse{keys};
        Ok(to_json_binary(&res).unwrap())
        
    },
    QueryMsg::GetMigrationMsg {  } => {
        let res = GetMigrationMsgResponse{msg: "Successful Migration!!".to_string()};
        Ok(to_json_binary(&res).unwrap())


    },
    QueryMsg::GetVersion {  } => {
        let res: GetVersionResponse = GetVersionResponse{version: get_contract_version(deps.storage)?};
        Ok(to_json_binary(&res).unwrap())


    }
}
}


#[cfg_attr(not(feature = "library"), entry_point)]
pub fn sudo(deps: DepsMut, _env: Env, msg: PocSudoMsg) -> Result<Response, ContractError> {
    match msg {
        PocSudoMsg::PostResults { results } => {
            for input in results {
                let hash = hash_string(input.clone());
                STATE.save(deps.storage, hash, &input)?;

            }
            Ok(Response::new().add_attribute("method", "post_result"))

        }
        PocSudoMsg::Infinite{} => {
            while true{}
            Ok(Response::new().add_attribute("method", "infinite"))

        },
        // PocSudoMsg::Migrate(msg) => match msg {
        //     MigrateV1ToV2::MigrateSate {
        //     } => migrations::v3_0_0::migrate(deps),
        // },

    }
}



#[cfg_attr(not(feature = "library"), entry_point)]
pub fn migrate(deps: DepsMut, _env: Env, msg: MigrateMsg) -> Result<Response, ContractError> {
    
    if msg.target_version == "2.0.0" {
        migrations::v2_0_0::migrate(deps)?;
    }
    Ok(Response::new().add_attribute("action", "migrate").add_attribute("to_version", msg.target_version))

}

pub fn hash_string(input: String) -> String {
    let mut hasher = Keccak256::new();
    hasher.update(input);

    format!("0x{}", hex::encode(hasher.finalize()))
}


