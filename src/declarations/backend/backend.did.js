export const idlFactory = ({ IDL }) => {
  const Time = IDL.Int;
  const Event = IDL.Record({
    'owner' : IDL.Opt(IDL.Principal),
    'time' : Time,
    'message' : IDL.Text,
    'scan_count' : IDL.Nat,
    'event_name' : IDL.Text,
    'event_type' : IDL.Text,
    'owner_name' : IDL.Opt(IDL.Text),
    'images' : IDL.Opt(IDL.Vec(IDL.Vec(IDL.Nat8))),
  });
  const Boot = IDL.Service({
    'abandon_ownership' : IDL.Func([IDL.Text, IDL.Text], [IDL.Bool], []),
    'get_history' : IDL.Func([], [IDL.Vec(Event)], ['query']),
    'get_last_event' : IDL.Func([], [Event], ['query']),
    'get_timer' : IDL.Func([], [Time], ['query']),
    'modify_asset' : IDL.Func([IDL.Text, IDL.Text], [IDL.Bool], []),
    'owning_state' : IDL.Func([], [IDL.Int], []),
    'request_ownership' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Text, IDL.Text],
        [IDL.Bool],
        [],
      ),
    'update_asset' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Text, IDL.Text],
        [IDL.Bool],
        [],
      ),
    'url_scan_tag' : IDL.Func([IDL.Text], [IDL.Bool], []),
  });
  return Boot;
};
export const init = ({ IDL }) => { return []; };
