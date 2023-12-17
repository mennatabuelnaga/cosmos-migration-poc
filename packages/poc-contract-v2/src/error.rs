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

    CW721Error(#[from] cw721_base::ContractError),
    
    #[error("Semver parsing error: {0}")]
    SemVer(String),
}


impl From<semver::Error> for ContractError {
    fn from(err: semver::Error) -> Self {
        Self::SemVer(err.to_string())
    }
}