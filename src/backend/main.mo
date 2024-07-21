import Principal "mo:base/Principal";
// import Http "mo:certified-cache/Http";
import Text "mo:base/Text";
import Bool "mo:base/Bool";
import Array "mo:base/Array";
import Time "mo:base/Time";
import Scan "scan";
import Event "event";

shared ({ caller = creator }) actor class Boot() = this {

    // TODO : Put everything stable for final version, not yet for testing purposes
    var owner : ?Principal = null;
    var owner_name : ?Text = null;
    var scan_count : Nat = 0;
    var history : [Event.Event] = [{
        event_type = "Emanated";
        event_name = "Emanated";
        owner_name = null;
        owner = null;
        scan_count = 0;
        time = Time.now();
        images = null;
        message = "The boot emanated from the internet."
    }];
    var timer: Time.Time = 0;
    var counter = 0;
    ////////////////////////////////////////////////////


    // to set the owner of the boot, only works if the boot has no owner
    public shared({caller}) func request_ownership(_owner_name: Text, url: Text, event_name: Text, message: Text) : async Bool {
        assert(owner == null);


        // TODO : Put it back, removed for testing purposes
        // let counter = Scan.scan(url, scan_count);
        // assert(counter > 0);
        // scan_count := counter;
        ////////////////////////////////////////////////////
        
        owner := ?caller;
        owner_name := ?_owner_name;
        counter := 0;
        history := Array.append(history, [{
            event_type = "Owned";
            event_name = event_name;
            owner_name = owner_name;
            owner = owner;
            scan_count = scan_count;
            time = Time.now();
            images = ?[];
            message = message;
        }]);
        true
    };

    // to abandon the ownership of the boot
    public shared({caller}) func abandon_ownership(event_name: Text, message: Text) : async Bool {
        assert (?caller == owner);

        counter := 0;
        history := Array.append(history, [{
            event_type = "Abandoned";
            event_name = event_name;
            owner_name = owner_name;
            owner = owner;
            scan_count = scan_count;
            time = Time.now();
            images = null;
            message = message;
        }]);
        owner := null;
        owner_name := null;
        true
    };

    // to abandon the ownership of the boot
    public shared({caller}) func update_asset(url: Text, _event_name: Text, _sender_name: Text, _message: Text) : async Bool {


        // TODO : Put it back, removed for testing purposes
        // let counter = Scan.scan(url, scan_count);
        // assert(counter > 0);
        // scan_count := counter;
        ////////////////////////////////////////////////////

        var name = ?_sender_name;

        // check if the update is call weither by the owener or by a stranger (only once every 24h)
        if (?caller != owner and Time.now() - timer < 1_000_000_000 * 60 * 60 * 24) {
            return false;
        };
        
        if (?caller != owner) {
            counter += 1;
            timer := Time.now();
        }
        else {
            counter := 0;
            name := owner_name;
        };

        history := Array.append(history, [{
            event_type = "Updated";
            event_name = _event_name;
            owner_name = name;
            owner = owner;
            scan_count = scan_count;
            time = Time.now();
            images = null;
            message = _message;
        }]);



  

        if (counter < 7) { return true; };

        // if the update is called by a stranger more than 7 times, the boot is abandoned
        // just an exemple, might find another way to handle this (user not abandoning their ownership when they should, etc.)
        history := Array.append(history, [{
            event_type = "Abandoned";
            event_name = "Lost Ownership";
            owner_name = owner_name;
            owner = owner;
            scan_count = scan_count;
            time = Time.now();
            images = null;
            message = "The boot were abandoned because a stranger updated the boot 7 times.";
        }]);
        true
    };

    // to get the current owner of the boot, 0 if none, 1 if the caller is the owner, 2 if someone else own the boot
    public shared({caller}) func owning_state() : async Int {
        if (owner == null) {
            return 0;
        }
        else if (?caller == owner) {
            return 1;
        };
        return 2;
    };

    // to verify the shoes are valid, only workd if the url come from the NFC tag
    public shared func url_scan_tag(url: Text) : async Bool {
        let counter = Scan.scan(url, scan_count);
        if (counter <= 0) {
          return false;
        };
        scan_count := counter;
        true
    };

    // to get history of the boot
    public query func get_history() : async [Event.Event] {
        history
    };

    // to get the last event of the boot
    public query func get_last_event() : async Event.Event {
        Event.get_last_event(history)
    };

    // return the time before an update can be called by a stranger
    public query func get_timer() : async Time.Time {
        Time.now() - timer
    };
};
