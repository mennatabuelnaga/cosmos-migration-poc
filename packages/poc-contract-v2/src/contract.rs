#[cfg(not(feature = "library"))]
use cosmwasm_std::entry_point;
use cosmwasm_std::{Binary, Deps, DepsMut, Env, MessageInfo, Response, StdResult, to_json_binary};
use cw2::set_contract_version;
use crate::error::ContractError;
use crate::msg::{ExecuteMsg, InstantiateMsg, QueryMsg, GetStateSizeResponse, GetStateKeysResponse, MigrateMsg, GetMigrationMsgResponse};
use crate::state::{STATE, NUM_RESULTS};
use sha3::{Digest, Keccak256};
use cw2::get_contract_version;
use semver::Version;

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
        ExecuteMsg::PostResults { results, times_to_loop, modify_state } => {
            
            for i in 0..times_to_loop {
                let num_results = NUM_RESULTS.load(deps.storage)?;
                STATE.save(deps.storage, (num_results + i), &results)?;
                NUM_RESULTS.save(deps.storage, &(num_results + i))?;
            }

            if modify_state {
                let num_results = NUM_RESULTS.load(deps.storage)?;
                for i in 1..(num_results) {
                    // append "-migrated" to the end of each result
                    let result = STATE.may_load(deps.storage, i)?;
                    match result {
                        Some(mut r) => {
                            r.push_str("-migrated");
                            STATE.save(deps.storage, i, &r)?;
                        },
                        None => {},
                    }
                    
                }
            }

            Ok(Response::new().add_attribute("method", "post_result"))
        },
   
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
        let keys = STATE.keys(deps.storage, None, None, cosmwasm_std::Order::Ascending).collect::<Result<Vec<u128>, _>>()?;
        let res: GetStateKeysResponse = GetStateKeysResponse{keys};
        Ok(to_json_binary(&res).unwrap())
        
    },
    QueryMsg::GetMigrationMsg {  } => {
        let res = GetMigrationMsgResponse{msg: "Successful Migration!!".to_string()};
        Ok(to_json_binary(&res).unwrap())


    },
   
}
}




#[cfg_attr(not(feature = "library"), entry_point)]
pub fn migrate(deps: DepsMut, _env: Env, _msg: MigrateMsg) -> Result<Response, ContractError> {
    set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;
    let results = _msg.results;
    let times_to_loop = _msg.times_to_loop;
    let modify_state = _msg.modify_state;

    for i in 0..times_to_loop {
        let num_results = NUM_RESULTS.load(deps.storage)?;
        STATE.save(deps.storage, (num_results + i), &results)?;
        NUM_RESULTS.save(deps.storage, &(num_results + i))?;
    }

    if modify_state {
        let num_results = NUM_RESULTS.load(deps.storage)?;
        for i in 1..(num_results) {
            // append "-migrated" to the end of each result
            let result = STATE.may_load(deps.storage, i)?;
            match result {
                Some(mut r) => {
                    r.push_str("-migrated");
                    STATE.save(deps.storage, i, &r)?;
                },
                None => {},
            }
            
        }
    }

    Ok(Response::new().add_attribute("action", "migrate").add_attribute("to_version", CONTRACT_VERSION))

}
