use cosmwasm_schema::{cw_serde, QueryResponses};

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

  

}






#[cw_serde]

pub struct GetStateSizeResponse{
    pub size: usize
}


#[cw_serde]

pub struct GetStateKeysResponse{
    pub keys: Vec<String>
}

