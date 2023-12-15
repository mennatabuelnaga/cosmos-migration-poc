use cosmwasm_std::Addr;
use cw_storage_plus::{Map, Item};



pub const STATE: Map<String, String> = Map::new("inputs");

