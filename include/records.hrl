-record(tabrow_tab, {
    class           :: class(),
    id              :: id(),
    tag             :: term(),
    text            :: text(),
    body            :: body()
}).

-record(tabrow, {?ELEMENT_BASE(element_tabrow),
    tabs=[]         :: [#tabrow_tab{} | '|'],
    tag             :: term(),
    selected        :: id(),
    target          :: id(),
    mode            :: tabs | pills,
    orientation=top :: top | right | bottom | left
}).
