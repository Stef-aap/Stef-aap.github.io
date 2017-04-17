  # ***************************************
  def _On_Insert_Python ( self, event = None ) :
    # Create a unique number for the New Code section
    Exists = self.Code_Refs.keys ()
    Nr = 1
    while Nr in Exists :
      Nr += 1

    frame = self.web.page().currentFrame()
    doc   = frame.documentElement ()

    #print dir ( frame )

    # insert Samp
    Html = '<samp id="CMS_%s" style="display: none;">' %Nr + '\n\n</samp>'
    self.execCommand ( 'insertHtml', Html )
    ##Ref.CodeMirror.appendOutside ( Html )

    # call Samp_2_CodeMirror
    # Convert <samp> to CodeMirror
    Samps = doc.findAll ( 'samp' )
    for Samp in Samps :
      ID = unicode ( Samp.attribute ( 'id' ) )
      if ID.startswith ( 'CMS_' ) :
        # extract the unique number
        if Nr == int ( ID [ 4: ] ) :
          # create the ID for CodeMirror
          CM = 'CM_%s' % Nr

          # replace TextArea by CodeMirror
          Language = unicode ( TextArea.attribute ( 'name' ) )
          if not ( Language ) :
            Language = 'python'
          self.Code_Refs.Set_Language ( Nr, Language )

          JS = """%s = Something_2_CodeMirror ( "%s","%s" )""" % ( CM, ID, CM )
          frame.evaluateJavaScript ( JS )

          CodeMirror, Table = self._Ensure_Result_Table ( Nr )
          break


  # **************************************************
  # ***************************************************
  def _On_Load_Finished ( self, event = None ) :
    if event :
      frame = self.web.page().mainFrame()
      doc = frame.documentElement()
      self.Code_Refs = _Code_Refs ( self.web )

      # test if file is local and in editable list
      URL = unicode ( self.web.url().toString() )
      if URL.startswith ( 'file:///' ) :
        URL = URL [ 8: ]

      print 'Load_finished',URL

      self.New_Locals [ 'frame' ] = frame
      self.New_Locals [ 'doc'   ] = doc

      # Remove all CodeMirrors
      CMs = doc.findAll ( 'div[class="CodeMirror"]' )
      #print type(CMs), CMs, len(CMs)
      #if CMs :
      try :
        for CM in CMs :
          CM_ID = CM.attribute ( 'id' )
          CM.removeFromDocument ()
      except :
        pass

      # Convert <samp> to CodeMirror
      ##B = doc.findAll ( 'samp' )
      B = doc.findAll ( 'textarea' )
      #if B :
      try :
        for TextArea in B :
          ID = unicode ( TextArea.attribute ( 'id' ) )
          if ID.startswith ( 'CMS_' ) :
            # extract the unique number
            Nr = int ( ID [ 4: ] )
            # create the ID for CodeMirror
            CM = 'CM_%s' % Nr

            # replace TextArea by CodeMirror
            # don't use stopping mechanism in JavaScipt, like alert
            # because they will block JS, but this program will continue
            Language = unicode ( TextArea.attribute ( 'name' ) )
            if not ( Language ) :
              Language = 'python'
            self.Code_Refs.Set_Language ( Nr, Language )

            JS = """%s = Something_2_CodeMirror ( "%s","%s" )""" % ( CM, ID, CM, Language )
            ##JS = """%s = CodeMirror.fromTextArea ( document.getElementById("%s" ),{mode:"htmlmixed", lineNumbers:true, tabMode:"indent"});""" % ( CM, ID )
            print 'JJSSJS', JS,CM,ID
            """
    <script>
      var editor = CodeMirror.fromTextArea(document.getElementById("CMS_1"), {mode: "htmlmixed", lineNumbers: true, tabMode: "indent"});
    </script>
            """
            frame.evaluateJavaScript ( JS )
      except :
        pass

      # after a little while, do the rest of the process
      if sys.gui_support_version == 'WX' :
        wx.CallLater ( 300, self._On_Load_Finished2, doc, B )
      else :
        self._On_Load_Finished2 ( doc, B )

  # **************************************************
  # ***************************************************
  def _On_Load_Finished2 ( self, doc, B ) :
    try :
      for Samp in B :
        ID = unicode ( Samp.attribute ( 'id' ) )
        if ID.startswith ( 'CMS_' ) :
          Nr = int ( ID [ 4: ] )
          CodeMirror, Table = self._Ensure_Result_Table ( Nr )
    except :
      pass
  # **************************************************
  # **************************************************
  def _Ensure_Result_Table ( self, Nr ) :
    frame = self.web.page().mainFrame()
    doc = frame.documentElement()

    # Find the CodeMirror
    CM = 'CM_%s' % Nr
    CMs = doc.findAll ( 'div[class="CodeMirror"]' )
    for CodeMirror in CMs :
      print 'JJJJJAA',CodeMirror.attribute('id'), CM
      if CodeMirror.attribute ( 'id' ) == CM :
        break
    else :
      print 'NNNNO'  ##, CodeMirror.attribute ( 'id' )
      return None, None

    # check if result table available
    TID = 'RT_%s' % Nr
    Table = doc.findFirst ( 'table[id="%s"]' % TID )
    if Table.isNull() :

      # append Result table if not available
      Html = """
<p></p>
<table id="%s" class="Python_Result" style="width=100%%;">
    <tbody><tr>
      <td></td>
    </tr>
</tbody></table>
    """ % ( 'RT_%s' % Nr )
      Table = CodeMirror.appendOutside ( Html )
      Table = doc.findFirst ( 'table[id="%s"]' % TID )

    if CodeMirror :
      self.Code_Refs.Add_Set ( Nr, CodeMirror, Table )

    return CodeMirror, Table
  # **************************************************

