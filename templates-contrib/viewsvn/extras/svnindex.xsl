<?xml version="1.0"?>

<!-- A sample XML transformation style sheet for displaying the Subversion
  directory listing that is generated by mod_dav_svn when the "SVNIndexXSLT"
  directive is used. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="viewvcroot">/viewvc/</xsl:variable>
  <xsl:variable name="docroot"></xsl:variable>

  <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />

  <xsl:template match="*"/>

  <xsl:template match="svn">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
        <title>
          <xsl:if test="string-length(index/@name) != 0">
            <xsl:value-of select="index/@name"/>
            <xsl:text>: </xsl:text>
          </xsl:if>
          <xsl:value-of select="index/@path"/>
        </title>
        <link rel="shortcut icon" href="/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="/svnindex.css"/>
      </head>
      <body>
        <div class="svn">
          <xsl:apply-templates/>
        </div>
        <div class="footer">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:text>Subversion</xsl:text>
          </xsl:element>
          <xsl:text> </xsl:text>
          <xsl:value-of select="@version"/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="index">
    <div class="rev">
      <xsl:if test="string-length(@name) != 0">
        <xsl:value-of select="@name"/>
        <xsl:if test="string-length(@rev) != 0">
          <xsl:text> &#8212; </xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="string-length(@rev) != 0">
        <xsl:text>Revision </xsl:text>
        <xsl:value-of select="@rev"/>
      </xsl:if>
    </div>
    <div class="path">
      <xsl:value-of select="@path"/>
    </div>
    <xsl:apply-templates select="updir"/>
    <xsl:apply-templates select="dir"/>
    <xsl:apply-templates select="file"/>
  </xsl:template>

  <xsl:template match="updir">
    <div class="updir">
      <a href=".." class="img" title="Parent Directory"><img src="{$docroot}/images/tortoisesvn/back.png" alt="Parent Directory" width="16" height="16"/></a>
      <xsl:text> </xsl:text>
      <xsl:text>[</xsl:text>
      <xsl:element name="a">
        <xsl:attribute name="href">..</xsl:attribute>
        <xsl:text>Parent Directory</xsl:text>
      </xsl:element>
      <xsl:text>]</xsl:text>
    </div>
    <!-- xsl:apply-templates/ -->
  </xsl:template>

  <xsl:template match="dir">
    <div class="dir">
      <xsl:choose>
        <xsl:when test="../@path = 'Collection of Repositories'">
          <a href="{$viewvcroot}{@href}" class="img" title="{@name}"><img src="{$docroot}/images/dir.png" alt="{@name}" width="16" height="16"/></a>
        </xsl:when>
        <xsl:when test="../@path = '/'">
          <a href="{$viewvcroot}{../@base}{../@path}{@href}?revision={../@rev}" class="img" title="{@name}"><img src="{$docroot}/images/dir.png" alt="{@name}" width="16" height="16"/></a>
        </xsl:when>
        <xsl:otherwise>
          <a href="{$viewvcroot}{../@base}{../@path}/{@href}?revision={../@rev}" class="img" title="{@name}"><img src="{$docroot}/images/dir.png" alt="{@name}" width="16" height="16"/></a>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text> </xsl:text>
      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:choose>
            <xsl:when test="../@path = 'Collection of Repositories'">
              <xsl:value-of select="$viewvcroot" />
              <xsl:value-of select="@href"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$viewvcroot" />
              <xsl:value-of select="../@base" />
              <xsl:value-of select="../@path" />
              <xsl:if test="../@path != '/'">
                <xsl:text>/</xsl:text>
              </xsl:if>
              <xsl:value-of select="@href"/>
              <xsl:text>?revision=</xsl:text>
              <xsl:value-of select="../@rev"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
        <xsl:text>/</xsl:text>
      </xsl:element>
    </div>
    <!-- <xsl:apply-templates/ -->
  </xsl:template>

  <xsl:template match="file">
    <div class="file">
      <a href="{$viewvcroot}{../@base}{../@path}/{@href}?revision={../@rev}&amp;view=markup" class="img" title="{@name}"><img src="{$docroot}/images/text.png" alt="{@name}" width="16" height="16"/></a>
      <xsl:text> </xsl:text>
      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:value-of select="$viewvcroot" />
          <xsl:value-of select="../@base" />
          <xsl:value-of select="../@path" />
          <xsl:text>/</xsl:text>
          <xsl:value-of select="@href"/>
          <xsl:text>?revision=</xsl:text>
          <xsl:value-of select="../@rev"/>
          <xsl:text>&amp;view=markup</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </xsl:element>
    </div>
    <!-- xsl:apply-templates/ -->
  </xsl:template>

</xsl:stylesheet>
