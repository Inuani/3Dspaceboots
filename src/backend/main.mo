import Principal "mo:base/Principal";
// import Http "mo:certified-cache/Http";
import Text "mo:base/Text";
import Error "mo:base/Error";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Bool "mo:base/Bool";
import Scan "scan";

shared ({ caller = creator }) actor class Boot() = this {

    stable var scan_count : Nat = 0;

    var name : Text = "Boot";

    public query func sayHelloTo(name : Text) : async Text {
    return "Hello " # name # " 👋 ";
  };

  public query func calc(a : Nat, b : Nat) : async Nat {
    return a + b;
  };

    public shared ({ caller }) func url_scan_tag(url: Text) : async Bool {
      Debug.print(Principal.toText(caller));
        let counter = Scan.scan(url, scan_count);
        if (counter <= 0) {
          return false
        };
        scan_count := counter;
        return true;
  };


    // public query func http_request(request : Http.HttpRequest) : async Http.HttpResponse {

    //     let counter = Scan.scan(request.url, scan_count);

    //     Debug.print("Valid: " # Nat.toText(counter)# " Scan Count: " # Nat.toText(scan_count));
    //     let new_request = {
    //         url = if (counter > 0) {
    //             "/valid.html"
    //         } else {
    //             "/invalid.html"
    //         };
    //         method = request.method;
    //         body = request.body;
    //         headers = request.headers;
    //     };

    //     let res = Frontend.http_request(new_request);

    //     return {
    //         body = res.body;
    //         headers = res.headers;
    //         status_code = res.status_code;
    //         streaming_strategy = null;
    //         upgrade = if (counter > 0) { ?true } else { ?false };
    //     };
    // };

};
