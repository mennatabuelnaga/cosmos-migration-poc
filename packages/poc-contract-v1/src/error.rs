use cosmwasm_std::StdError;
use thiserror::Error;
use cw2::VersionError;
#[derive(Error, Debug)]
pub enum ContractError {
    #[error("{0}")]
    Std(#[from] StdError),

    #[error("Unauthorized")]
    Unauthorized,
    
    #[error("{0}")]
    WrongVersion(#[from] VersionError),

    #[error("{0}")]

    CW721Error(#[from] cw721_base::ContractError)
    
    // Add any other custom errors you like here.
    // Look at https://docs.rs/thiserror/1.0.21/thiserror/ for details.
}
