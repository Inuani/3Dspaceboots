import Principal "mo:base/Principal";
// import Http "mo:certified-cache/Http";
import Text "mo:base/Text";
import Bool "mo:base/Bool";
import Array "mo:base/Array";
import Result "mo:base/Result";
import Time "mo:base/Time";
import Scan "scan";
import Event "event";

shared ({ caller = creator }) actor class Boot() = this {

    stable var owner : ?Principal = null;

    stable var stolen : Bool = false;

    stable var lost : Bool = false;

    stable var scan_count : Nat = 0;

    type Result<Ok, Err> = {#ok : Ok; #err : Err};



    stable var history : [Event.Event] = [];

    var _name : Text = "Boot";

    // to set the owner of the boot, only works if the boot is not stolen and has no owner
    public shared func set_owner(owner_name: Text, _owner : Principal, url: Text) : async Bool {

        if ((owner != null or stolen) and not lost) {
            return false;
        };

        let counter = Scan.scan(url, scan_count);
        if (counter <= 0) {
          return false;
        };
        owner := ?_owner;
        lost := false;
        history := Array.append(history, [{
            event_type = #NewOwner;
            owner_name = ?owner_name;
            owner = ?_owner;
            scan_count = scan_count;
            time = Time.now();
            images = ?[];
        }]);
        true
    };

    // to abandon the ownership of the boot
    public shared({caller}) func abandon_ownership() : async Bool {
        if (?caller != owner) {
            return false;
        };
        owner := null;
        history := Array.append(history, [{
            event_type = #OwnerShipAbandoned;
            owner_name = null;
            owner = null;
            scan_count = scan_count;
            time = Time.now();
            images = null;
        }]);
        true
    };

    // to report the boot as lost, if someone find it, they can own it
    public shared({caller}) func report_lost() : async Bool {
        if (?caller != owner) {
            return false;
        };
        lost := true;
        history := Array.append(history, [{
            event_type = #Lost;
            owner_name = null;
            owner = null;
            scan_count = scan_count;
            time = Time.now();
            images = null;
        }]);
        true
    };

    // to report the boot as stolen, the thief can't own it, the boots are useless to them since the boot is reported as stolen
    public shared({caller}) func report_steal() : async Bool {
        if (?caller != owner) {
            return false;
        };
        stolen := true;
        history := Array.append(history, [{
            event_type = #Stolen;
            owner_name = null;
            owner = null;
            scan_count = scan_count;
            time = Time.now();
            images = null;
        }]);
        true
    };

    // to report the boot as found, only the owner can find find them back, a new owener will just be a new owner
    public shared({caller}) func report_found() : async Bool {
        if (?caller != owner or history.size() < 2 or history[history.size() - 2].event_type != #Lost or history[history.size() - 1].event_type != #Stolen) {
            return false;
        };
        let last_owner_event = history[history.size() - 2];
        stolen := false;
        history := Array.append(history, [{
            event_type = #Found;
            owner_name = last_owner_event.owner_name;
            owner = last_owner_event.owner;
            scan_count = scan_count;
            time = Time.now();
            images = ?[];
        }]);
        true
    };

    public shared func url_scan_tag(url: Text) : async Bool {
        let counter = Scan.scan(url, scan_count);
        if (counter <= 0) {
          return false;
        };
        scan_count := counter;
        true
  };

    public shared func get_history(url: Text) : async Result<[Event.Event], Text> {
        let counter = Scan.scan(url, scan_count);
        if (counter <= 0) {
          return #err("Invalid URL");
        };
        scan_count := counter;
        #ok(history)
  };
};
