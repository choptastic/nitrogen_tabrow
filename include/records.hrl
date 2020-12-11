-record(tabrow_item, {
    id              :: id(),
    tag             :: term(),
    text            :: text(),
    body            :: body(),
    selected=false  :: boolean()
}).

-record(tabrow, {?ELEMENT_BASE(element_tabrow),
    tabs=[]         :: [#tabrow_item{} | '|'],
    tag             :: term(),
    selected        :: term(),
    orientation=top :: top | right | bottom | left
}).
