use cw_storage_plus::{Map, Item};



pub const STATE: Map<u128, String> = Map::new("inputs");
pub const NUM_RESULTS: Item<u128> = Item::new("num_results");

