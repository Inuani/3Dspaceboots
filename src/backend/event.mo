import Time "mo:base/Time";
import Array "mo:base/Array";
import Text "mo:base/Text";



module 
{

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