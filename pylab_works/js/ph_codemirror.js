//<!-- ****************************************************************** -->
//<script type="text/javascript">
var Last_Active_CodeMirror ;
var Weg_Marker ;

//    mode  : { name    : "python",
//            version : 2,
//            singleLineStringErrors : false },
//    {value: ME.innerHTML,
function Something_2_CodeMirror( ID, CM_ID, Language ) {
  if ( Language == "python" ) {
    My_Theme = "robbie" }
  else { My_Theme = "default" };

  var ME = document.getElementById ( ID );
  // some suggest you shouldn't use Editor, but "window[ID]"
  // I couldn't find any difference
  //window[ID] = CodeMirror(function(elt) {
  Editor = CodeMirror(function(elt) {
    ME.parentNode.replaceChild(elt,ME);},
    {value: unescape ( ME.value ),                      //Me.innerHTML escapes chars like "<"
    mode  : { name    : Language },
  theme         : My_Theme,
  lineNumbers   : true,
  lineWrapping  : true,
  indentUnit    : 2,
  tabMode       : "classic",
  matchBrackets : true,

    onKeyEvent: function(i, e) {
      // Hook into ctrl-space
//alert ( 'ppop===' + Last_Active_CodeMirror + '=='+ ID + '===' + CM_ID + '===' + Editor.getWrapperElement ().id );
//alert ( e.ctrlKey+'piep3'+e.keyCode);
      if (e.keyCode == 32 && (e.ctrlKey || e.metaKey) && !e.altKey) {
        e.stop();
        return startComplete(Editor);
      }
    },

  onGutterClick : function ( cm, n, event ) {
    var info = cm.lineInfo ( n );
    //alert ( "click-" + info.markerText )
    if ( event.ctrlKey )
      {
      alert ( 'CTTRL KEY' + event.ctrlKey );
      }
    if ( info.markerText === null )
      {
      cm.setLineClass ( n, "line_bp" );
      cm.setMarker ( n, "<span style=\"color: #900\">&#9658;</span> %N%" );
      }
    else if ( info.markerText.indexOf ( "9658" ) >= 0 )
      {
      cm.setMarker ( n, "<span style=\"color: #900\">&#9675;</span> %N%" );
      cm.setLineClass ( n, "line_bpc" );
      }
    else if ( info.markerText.indexOf ( "9675" ) >= 0 )
      {
      cm.setMarker ( n, "<span style=\"color: #900\">&#9679;</span> %N%" );
      cm.setLineClass ( n, "line_bpc_dis" );
      }
    else if ( info.markerText.indexOf ( "9679" ) >= 0 )
      {
      cm.clearMarker ( n );
      cm.setLineClass ( n );
      }
    cm.focus();
    },

  onFocus       : function (){
    //alert ( CM_ID + 'piep focus' + ID + '===' + Editor );
    Last_Active_CodeMirror = CM_ID
  },
  onChange      : function ( cm )
  {
    cm.MyOwn_Modified = true;
  }

  });

  // set the ID of the CodeMirror
  Editor.getWrapperElement ().id = CM_ID;

  // Clear the Modified flag
  Editor.MyOwn_Modified = false;

  // We return the Editor and not the DomNode
  // because we want to execute methods of the Editor
  return Editor;
};
// Return the global var, that shows the latest active CodeMirror
function Get_Last_Active_CodeMirror ()
{
  return Last_Active_CodeMirror
};

// extracts the contents from a textarea
// which isn't possible directly form QWebView
function Get_Value_From_TextArea ( ID ) {
  var TA_Value = document.getElementById ( ID ).value;
  //alert ( 'piep3');
  return TA_Value;
}
//</script>
//<!-- ****************************************************************** -->
