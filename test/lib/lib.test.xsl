<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"><xsl:template xmlns:ut="https://github.com/sttk/xslet/2019/xslutil" name="ut:get_dir_from_url"><xsl:param name="url"/><xsl:choose><xsl:when test="not(contains($url, '/'))">.</xsl:when><xsl:otherwise><xsl:call-template name="ut:_get_dir_from_url_r"><xsl:with-param name="url" select="$url"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:template><xsl:template xmlns:ut="https://github.com/sttk/xslet/2019/xslutil" name="ut:_get_dir_from_url_r"><xsl:param name="url"/><xsl:value-of select="substring-before($url, '/')"/><xsl:variable name="suburl" select="substring-after($url, '/')"/><xsl:if test="string-length($suburl) &gt; 0"><xsl:variable name="subdir"><xsl:call-template name="ut:_get_dir_from_url_r"><xsl:with-param name="url" select="$suburl"/></xsl:call-template></xsl:variable><xsl:if test="string-length($subdir) &gt; 0"><xsl:value-of select="concat('/', $subdir)"/></xsl:if></xsl:if></xsl:template><xsl:template xmlns:ut="https://github.com/sttk/xslet/2019/xslutil" name="ut:get_xsl_url"><xsl:param name="pi" select="/processing-instruction('xml-stylesheet')"/><xsl:variable name="QUOT">"</xsl:variable><xsl:variable name="APOS">'</xsl:variable><xsl:variable name="s1" select="substring-after($pi, 'href')"/><xsl:if test="normalize-space(substring-before($s1, '=')) = ''"><xsl:variable name="s2" select="substring-after($s1, '=')"/><xsl:choose><xsl:when test="substring($s2, 1, 1) = $QUOT"><xsl:value-of select="translate(substring-before(substring-after($s2, $QUOT), $QUOT), '\', '/')"/></xsl:when><xsl:when test="substring($s2, 1, 1) = $APOS"><xsl:value-of select="translate(substring-before(substring-after($s2, $APOS), $APOS), '\', '/')"/></xsl:when><xsl:otherwise><xsl:variable name="s3" select="normalize-space($s2)"/><xsl:choose><xsl:when test="substring($s3, 1, 1) = $QUOT"><xsl:value-of select="translate(substring-before(substring-after($s2, $QUOT), $QUOT), '\', '/')"/></xsl:when><xsl:when test="substring($s3, 1, 1) = $APOS"><xsl:value-of select="translate(substring-before(substring-after($s2, $APOS), $APOS), '\', '/')"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:if></xsl:template><xsl:template match="assert-equal[@name='ut:get_dir_from_url']"><xsl:variable name="result"><xsl:call-template xmlns:ut="https://github.com/sttk/xslet/2019/xslutil" name="ut:get_dir_from_url"><xsl:with-param name="url" select="url"/></xsl:call-template></xsl:variable><div><code><div><b>ut:get_dir_from_url</b><xsl:variable name="param">,url='<xsl:value-of select="url"/>'</xsl:variable><xsl:value-of select="concat('(', substring($param, 2), ')')"/> … <xsl:choose><xsl:when test="$result = expect"><span style="color:#0d0">PASS</span></xsl:when><xsl:otherwise><span style="color:#d00">FAIL</span><style>h2 { background-color: #f00 }</style></xsl:otherwise></xsl:choose></div><style/><div style="padding-left: 1rem">- Expect[<xsl:value-of select="expect"/>]</div><div style="padding-left: 1rem">- Result[<xsl:value-of select="$result"/>]</div></code></div><hr/></xsl:template><xsl:template match="assert-equal[@name='ut:_get_dir_from_url_r']"><xsl:variable name="result"><xsl:call-template xmlns:ut="https://github.com/sttk/xslet/2019/xslutil" name="ut:_get_dir_from_url_r"><xsl:with-param name="url" select="url"/></xsl:call-template></xsl:variable><div><code><div><b>ut:_get_dir_from_url_r</b><xsl:variable name="param">,url='<xsl:value-of select="url"/>'</xsl:variable><xsl:value-of select="concat('(', substring($param, 2), ')')"/> … <xsl:choose><xsl:when test="$result = expect"><span style="color:#0d0">PASS</span></xsl:when><xsl:otherwise><span style="color:#d00">FAIL</span><style>h2 { background-color: #f00 }</style></xsl:otherwise></xsl:choose></div><style/><div style="padding-left: 1rem">- Expect[<xsl:value-of select="expect"/>]</div><div style="padding-left: 1rem">- Result[<xsl:value-of select="$result"/>]</div></code></div><hr/></xsl:template><xsl:template match="assert-equal[@name='ut:get_xsl_url']"><xsl:variable name="result"><xsl:call-template xmlns:ut="https://github.com/sttk/xslet/2019/xslutil" name="ut:get_xsl_url"><xsl:with-param name="pi" select="pi"/></xsl:call-template></xsl:variable><div><code><div><b>ut:get_xsl_url</b><xsl:variable name="param">,pi='<xsl:value-of select="pi"/>'</xsl:variable><xsl:value-of select="concat('(', substring($param, 2), ')')"/> … <xsl:choose><xsl:when test="$result = expect"><span style="color:#0d0">PASS</span></xsl:when><xsl:otherwise><span style="color:#d00">FAIL</span><style>h2 { background-color: #f00 }</style></xsl:otherwise></xsl:choose></div><style/><div style="padding-left: 1rem">- Expect[<xsl:value-of select="expect"/>]</div><div style="padding-left: 1rem">- Result[<xsl:value-of select="$result"/>]</div></code></div><hr/></xsl:template><xsl:template match="/unit-test"><html><head><meta charset="utf-8"/><title><xsl:value-of select="@title"/></title></head><body><h2><xsl:value-of select="@title"/></h2><hr/><xsl:apply-templates select="*"/></body></html></xsl:template></xsl:stylesheet>