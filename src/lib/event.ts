

export function events(){
    return creation_events().concat(owning_events()).concat(abandoning_events()).concat(destruction_events()).concat(temporary_shared_events()).concat(modification_events());
};
export function creation_events() : Array<string>{
    return ["Emanted"];
};

export function owning_events(): Array<string>{
    return ["Created", "Bought", "Found", "Received", "Inherited"]
};

export function abandoning_events(): Array<string>{
    return ["Sold", "Lost", "Gifted", "OwnerDied", "Auctioned"]
};

export function destruction_events(): Array<string>{
    return ["Stolen", "Destroyed", "MaxScanCountReached"]
};

export function temporary_shared_events(): Array<string>{
    return ["Rented", "Borrowed", "Returned"]
};

export function modification_events(): Array<string> {
    return ["Upgraded", "Repaired", "Damaged", "Disassembled", "Recycled", "Renovated"]
};
