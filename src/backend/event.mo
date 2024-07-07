import Time "mo:base/Time";


module 
{
     public type EventType = {
        #NewOwner;
        #OwnerShipAbandoned;
        #Stolen;
        #Lost;
        #Found;

    };

    public type Event = {
        event_type : EventType;
        owner_name : ?Text;
        owner : ?Principal;
        scan_count : Nat;
        time : Time.Time;
        images : ?[Blob];
    };
}