import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Boot {
  'abandon_ownership' : ActorMethod<[string, string], boolean>,
  'get_history' : ActorMethod<[], Array<Event>>,
  'get_last_event' : ActorMethod<[], Event>,
  'get_timer' : ActorMethod<[], Time>,
  'modify_asset' : ActorMethod<[string, string], boolean>,
  'owning_state' : ActorMethod<[], bigint>,
  'request_ownership' : ActorMethod<[string, string, string, string], boolean>,
  'update_asset' : ActorMethod<[string, string, string, string], boolean>,
  'url_scan_tag' : ActorMethod<[string], boolean>,
}
export interface Event {
  'owner' : [] | [Principal],
  'time' : Time,
  'message' : string,
  'scan_count' : bigint,
  'event_name' : string,
  'event_type' : string,
  'owner_name' : [] | [string],
  'images' : [] | [Array<Uint8Array | number[]>],
}
export type Time = bigint;
export interface _SERVICE extends Boot {}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
