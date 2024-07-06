export const idlFactory = ({ IDL }) => {
  const Boot = IDL.Service({
    'calc' : IDL.Func([IDL.Nat, IDL.Nat], [IDL.Nat], ['query']),
    'sayHelloTo' : IDL.Func([IDL.Text], [IDL.Text], ['query']),
    'url_scan_tag' : IDL.Func([IDL.Text], [IDL.Bool], []),
  });
  return Boot;
};
export const init = ({ IDL }) => { return []; };
