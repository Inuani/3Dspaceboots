import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Boot {
  'calc' : ActorMethod<[bigint, bigint], bigint>,
  'sayHelloTo' : ActorMethod<[string], string>,
  'url_scan_tag' : ActorMethod<[string], boolean>,
}
export interface _SERVICE extends Boot {}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
