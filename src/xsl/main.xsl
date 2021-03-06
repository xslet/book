<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--** The URL of the XSL file. -->
 <xsl:param name="bk:xsl_url">
  <xsl:call-template name="ut:get_xsl_url"/>
 </xsl:param>

 <!--** The directory URL of the XSL file. -->
 <xsl:param name="bk:xsl_dir">
  <xsl:call-template name="ut:get_dir_from_url">
   <xsl:with-param name="url" select="$bk:xsl_url"/>
  </xsl:call-template>
 </xsl:param>

 <!--**
  The topmost element of xslbook document.
  `book` element is the legitimate element.
 -->
 <xsl:template match="/book">
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url"/>
  </xsl:variable>
  <html>
   <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>
     <xsl:apply-templates select="title">
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="allow">|title|for|if|choose|</xsl:with-param>
      <xsl:with-param name="allow_text_node"/>
     </xsl:apply-templates>
    </title>
    <xsl:call-template name="bk:_load_default_script"/>
    <xsl:apply-templates select="script"/>
    <xsl:call-template name="bk:_load_default_css"/>
    <xsl:apply-templates select="css"/>
   </head>
   <body>
    <main>
     <header>
      <xsl:call-template name="bk:print_navi"/>
     </header>
     <article class="book">
      <xsl:apply-templates select="title|for|if|choose">
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="allow">|title|for|if|choose|</xsl:with-param>
       <xsl:with-param name="allow_text_node"/>
       <xsl:with-param name="arg0">h1</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="toc">
       <xsl:with-param name="data_url" select="$_data_url"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="body|for|if|choose">
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="allow">|body|for|if|choose|</xsl:with-param>
       <xsl:with-param name="allow_text_node"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="toc">
       <xsl:with-param name="data_url" select="$_data_url"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="preface|chapter|appendix|postface">
       <xsl:with-param name="data_url" select="$_data_url"/>
      </xsl:apply-templates>
     </article>
     <footer>
      <xsl:call-template name="bk:print_navi"/>
     </footer>
    </main>
   </body>
  </html>
 </xsl:template>

 <xsl:template name="bk:_load_default_script">
  <script src="{concat($bk:xsl_dir, '/xslbook.js')}"></script>
 </xsl:template>

 <xsl:template name="bk:_load_default_css">
  <link rel="stylesheet" href="{concat($bk:xsl_dir, '/xslbook.css')}"/>
 </xsl:template>

 <!--**
  The element to print a title of page, chapter, section, etc.
  `arg0` is used for a element's tag name which encloses a title text if it is needed.
 -->
 <xsl:template match="title">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generated-id of a base node. -->
  <xsl:param name="data_gid"/>
  <!--** Elements which are allowed to be applied. -->
  <xsl:param name="allow"/>
  <!--** Any argument 0. In this element, `arg0` is used as a tag name which surrounds this title. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
  <xsl:param name="arg2"/>
  <xsl:variable name="_chapter_type" select="$arg1"/>
  <xsl:variable name="_chapter_index" select="$arg2"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_data_gid">
   <xsl:call-template name="bk:get_data_gid">
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($arg0) = 0">
    <xsl:apply-templates>
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:apply-templates>
   </xsl:when>
   <xsl:when test="$arg0 = 'h1'">
    <h1 class="title">
     <xsl:apply-templates>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
      <xsl:with-param name="arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:apply-templates>
    </h1>
   </xsl:when>
   <xsl:otherwise>
    <xsl:element name="{$arg0}">
     <xsl:attribute name="class">title</xsl:attribute>
     <span class="index index-in-{$_chapter_type}">
      <xsl:value-of select="$_chapter_index"/>
     </span>
     <span class="label">
      <xsl:apply-templates>
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="data_gid" select="$_data_gid"/>
       <xsl:with-param name="arg0"/>
       <xsl:with-param name="arg1" select="$arg1"/>
       <xsl:with-param name="arg2" select="$arg2"/>
      </xsl:apply-templates>
     </span>
    </xsl:element>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!--**
  The element to print contents of page, chapter, section, etc.
 -->
 <xsl:template match="body">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generated-id of a base node. -->
  <xsl:param name="data_gid"/>
  <!--** Elements which are allowed to be applied. -->
  <xsl:param name="allow"/>
  <!--** A flag if text node if allowed. -->
  <xsl:param name="allow_text_node"/>
  <!--** Any argument 0. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
  <xsl:param name="arg2"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_data_gid">
   <xsl:call-template name="bk:get_data_gid">
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <div class="body">
   <xsl:apply-templates>
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="data_gid" select="$_data_gid"/>
    <xsl:with-param name="allow" select="$allow"/>
    <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
    <xsl:with-param name="arg0" select="$arg0"/>
    <xsl:with-param name="arg1" select="$arg1"/>
    <xsl:with-param name="arg2" select="$arg2"/>
   </xsl:apply-templates>
  </div>
 </xsl:template>

 <!--**
   Load JavaScript files.
 -->
 <xsl:template match="/book/script">
  <xsl:choose>
   <xsl:when test="boolean(@href)">
    <script src="{@href}"></script>
   </xsl:when>
   <xsl:when test="boolean(@rpath)">
    <script src="{concat($bk:xsl_dir, '/', @rpath)}"></script>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <!--**
   Load CSS files.
 -->
 <xsl:template match="/book/css">
  <xsl:choose>
   <xsl:when test="boolean(@href)">
    <link rel="stylesheet" href="{@href}"/>
   </xsl:when>
   <xsl:when test="boolean(@rpath)">
    <link rel="stylesheet" href="{concat($bk:xsl_dir, '/', @rpath)}"/>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <!--**
   Set an unique ID to an element.
 -->
 <xsl:template name="bk:set_id">
  <xsl:attribute name="id">
   <xsl:call-template name="bk:get_id"/>
  </xsl:attribute>
 </xsl:template>

 <!--**
   Get a value of the attribute 'id' if it is specified, or create an unique ID otherwise.
 -->
 <xsl:template name="bk:get_id">
  <xsl:choose>
   <xsl:when test="string-length(@id) != 0">
    <xsl:value-of select="@id"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:text>idxbk</xsl:text>
    <xsl:variable name="_tagname" select="local-name()"/>
    <xsl:value-of select="$_tagname"/>
    <xsl:number level="any" format="1" count="*[name() = $_tagname]"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
