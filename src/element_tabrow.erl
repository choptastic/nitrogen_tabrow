-module(element_tabrow).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

-export([
	reflect/0,
	render_element/1,
    event/1
]).

reflect() -> record_info(fields, tabrow).

render_element(Rec = #tabrow{}) ->
    [].


event({tab, Tab}) ->
    [].
