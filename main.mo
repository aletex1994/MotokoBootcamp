import Array "mo:base/Array";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Map "mo:base/HashMap";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";

actor Registry {

  stable var entries : [(Text, Nat)] = [];

  var whitelist = TrieMap.TrieMap<Text,Nat>(Text.equal, Text.hash);

  public func registerAWhitelistValue(key : Text,value : Nat) : async Text {
   whitelist.put(key,whitelist.size());
   return "Whitelisted"; 
  };

  public func getValueFromKey(name : Text) : async ?Nat {
    whitelist.get(name);
  };

  public func getWhitelistSize() : async Nat {
    return whitelist.size();
  };

  public func showWhitelist() : async [(Text, Nat)] {
    entries := Iter.toArray(whitelist.entries());
    return entries;
  };
  public func removeItem(key : Text) : async ?Nat {
    return whitelist.remove(key);
  };
  public func clearWhitelist () {
   for((k,v) in whitelist.entries()){
     whitelist.delete(k); 
   };
  }; 
  public func findInWhitelist(key : Text) : async Bool {
    var found : Bool = false;
    for((k) in whitelist.keys()){
       if(k==key){
         found := true;
       };
    };
    return found;
  };

  public func arrayAsNewWhitelist( new_whitelist : [Text] ) : async [(Text,Nat)] {
   var i : Nat = 0;
    for(v in new_whitelist.vals()){
       whitelist.put(new_whitelist[i],whitelist.size());
       i+=1;
    };
    entries := Iter.toArray(whitelist.entries());
    return entries; 
  };

  public func greet (name : Text) : async Text {
    "Hello, " # name # "!";
  };
  
};