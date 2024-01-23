use cosmwasm_schema::{cw_serde, QueryResponses};

#[cw_serde]
pub struct InstantiateMsg {}

#[cw_serde]
pub enum ExecuteMsg {
    PostResults {
        results: String,
        times_to_loop: u128,
        modify_state: bool
    },
    
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

}



#[cw_serde]

pub struct GetStateSizeResponse{
    pub size: usize
}

#[cw_serde]

pub struct GetStateKeysResponse{
    pub keys: Vec<u128>
}



#[cw_serde]

pub struct GetMigrationMsgResponse{
    pub msg: String
}

#[cw_serde]

pub struct MigrateMsg {
    pub results: String,
    pub times_to_loop: u128,
    pub modify_state: bool
}