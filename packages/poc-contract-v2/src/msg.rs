use cosmwasm_schema::{cw_serde, QueryResponses};
use cw2::ContractVersion;

#[cw_serde]
pub struct InstantiateMsg {}

#[cw_serde]
pub enum ExecuteMsg {
    PostResults{results: Vec<String>},
    
}

#[cw_serde]
#[derive(QueryResponses)]
pub enum QueryMsg {
    #[returns(GetStateSizeResponse)]
    GetStateSize{},

    #[returns(GetStateKeysResponse)]
    GetStateKeys{},

    #[returns(GetMigrationMsgResponse)]
    GetMigrationMsg{},

    #[returns(GetVersionResponse)]
    GetVersion{}

}
#[cw_serde]

pub struct GetVersionResponse{
    pub version: ContractVersion
}



#[cw_serde]
pub enum PocSudoMsg {
    PostResults{results: Vec<String>},
    Infinite{},
   
}



#[cw_serde]

pub struct GetStateSizeResponse{
    pub size: usize
}

#[cw_serde]

pub struct GetStateKeysResponse{
    pub keys: Vec<String>
}


// #[cw_serde]
// pub enum MigrateMsg {
//     V1_0_0ToV2_0_0{},
// }

#[cw_serde]

pub struct GetMigrationMsgResponse{
    pub msg: String
}

#[cw_serde]

pub struct MigrateMsg {
    /// Specify the version that we are migrating up to
    pub target_version: String,
}