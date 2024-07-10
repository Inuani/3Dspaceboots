import Time "mo:base/Time";
import Array "mo:base/Array";
import Text "mo:base/Text";



module 
{

    // public func is_in<T>(events : [T], event_type : T) : Bool {
    //     switch (Array.find<T>(events, func (e : T) {e == event_type}))
    //     {
    //         case (null) {false};
    //         case (_) {true};
    //     }
    // };

    // public func events() : [Text] {
    //     Array.append(creation_events(), Array.append(owning_events(), Array.append(abandoning_events(), Array.append(destruction_events(), Array.append(temporary_shared_events(), modification_events())))))
    // };

    // public func is_event(event_type : Text) : Bool {
    //     is_in(events(), event_type)
    // };

    // public func creation_events() : [Text] {
    //     ["Emanted"]
    // };


    // public func is_creation_event(event_type : Text) : Bool {
    //     is_in(creation_events(), event_type)
    // };

    // public func owning_events() : [Text] {
    //     ["Bought", "Found", "Received", "Inherited"]
    // };

    // public func is_owning_event(event_type : Text) : Bool {
    //     is_in(owning_events(), event_type)
    // };

    // public func abandoning_events() : [Text] {
    //     ["Sold", "Lost", "Gifted", "OwnerDied", "Auctioned"]
    // };

    // public func is_abandoning_event(event_type : Text) : Bool {
    //     is_in(abandoning_events(), event_type)
    // };

    // public func destruction_events() : [Text] {
    //     ["Stolen", "Destroyed", "MaxScanCountReached"]
    // };

    // public func is_destruction_event(event_type : Text) : Bool {
    //     is_in(destruction_events(), event_type)
    // };

    // public func temporary_shared_events() : [Text] {
    //     ["Rented", "Borrowed", "Returned"]
    // };

    // public func is_temporary_shared_event(event_type : Text) : Bool {
    //     is_in(temporary_shared_events(), event_type)
    // };

    // public func modification_events() : [Text] {
    //     ["Upgraded", "Repaired", "Damaged", "Disassembled", "Recycled", "Renovated"]
    // };

    // public func is_modification_event(event_type : Text) : Bool {
    //     is_in(modification_events(), event_type)
    // };

    public type Event = {
        event_type : Text;
        event_name: Text;
        message: Text;
        owner_name : ?Text;
        owner : ?Principal;
        scan_count : Nat;
        time : Time.Time;
        images : ?[Blob];
    };

    public func get_last_event(events : [Event]) : Event {
        events[events.size() - 1]
    };
}