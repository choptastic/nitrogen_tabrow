-module(element_tabrow).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

-export([
	reflect/0,
	render_element/1,
    event/1
]).


-define(SELECTED, tabrow_selected).

reflect() -> record_info(fields, tabrow).

render_element(#tabrow{
        class=Class,
        tabs=Tabs,
        tag=TabrowTag,
        selected=Selected,
        target=Targetid,
        mode=Mode,
        orientation=Orientation}) ->
    Wrapperid = wf:temp_id(),

    OrientationClass = "tabrow_" ++ wf:to_list(Orientation),
    ModeClass = "tabrow_" ++ wf:to_list(Mode),

    #panel{id=Wrapperid, class=[tabrow, Class, ModeClass, OrientationClass], body=[
        [draw_tab(Wrapperid, Targetid, TabrowTag, Selected, Tab) || Tab <- Tabs]
    ]}.

draw_tab(Wrapperid, Targetid, TabrowTag, Selected, #tabrow_tab{
                                                    id=Tabid,
                                                    tag=TabTag,
                                                    text=Text,
                                                    body=Body,
                                                    class=Class
                                                }) ->

    TabidClass = ?WF_IF(Tabid=="", wf:normalize_id("tabrow_blank"), wf:normalize_id(Tabid)),
    SelectedClass = ?WF_IF(wf:to_list(Selected)==wf:to_list(Tabid), ?SELECTED),
    #link{
        class=[tabrow_tab, TabidClass, SelectedClass, Class],
        text=Text,
        body=Body,
        postback={tab, Wrapperid, Targetid, Tabid, TabrowTag, TabTag},
        delegate=?MODULE
    }.


event({tab, Wrapperid, Targetid, Tabid, TabrowTag, TabTag}) ->
    Mod = wf:page_module(),
    case Mod:tabrow_event(TabrowTag, TabTag) of
        {ok, Body} -> 
            wf:defer(".wfid_" ++ Wrapperid ++ " .tabrow_tab", #remove_class{class=tabrow_selected}),
            wf:defer(Tabid, #add_class{class=tabrow_selected}),
            wf:update(Targetid, Body),
            ok;
        ok -> 
            wf:defer(".wfid_" ++ Wrapperid ++ " .tabrow_tab", #remove_class{class=tabrow_selected}),
            wf:defer(Tabid, #add_class{class=tabrow_selected}),
            ok;
        Result ->
            error_logger:warning_msg("Failed tabrow_event:~nTabrowTag: ~p~nTabTag: ~p~n~nResult from tabrow_event: ~p~n",[TabrowTag, TabTag, Result])
   end.

    
