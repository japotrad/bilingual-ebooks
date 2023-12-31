﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:its="http://www.w3.org/2005/11/its" xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="db its xsl xlink" version="2.0">
<xsl:variable name="mainLang" select="/db:book/@xml:lang" />
<xsl:variable name="originLang" select="/db:book/@xml:lang" /> <!-- Language of the original document -->
<xsl:variable name="transLang" select="/db:book/db:title[1]/db:foreignphrase[1]/@xml:lang" /> <!-- Language of the translated document -->
<xsl:template match="element() | comment() | processing-instruction()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>
<xsl:template match="db:abstract">
    <h3>
        <xsl:text>Résumé　</xsl:text>
        <span>
            <xsl:attribute name="lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:text>〜〜あらすじ〜〜</xsl:text>
        </span>
    </h3>
    <p>
        <xsl:value-of select="db:para/text()"/>
    </p>
    <p>
            <xsl:attribute name="lang">
                <xsl:value-of select="db:para/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="db:para/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates select="db:para/db:foreignphrase/text()"/>
    </p>
</xsl:template>
<xsl:template match="db:appendix">
    <!--  XHTML file for the appendix -->
    <xsl:result-document href="{lower-case(db:title/text())}.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8" include-content-type="no">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <head>
                <title>
                    <xsl:value-of select="db:title/text()"/>
                </title>
                    <link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <h1>
                        <xsl:copy-of select="db:title/text()"/>
                        <xsl:if test="db:title/db:foreignphrase">
                            <span>
                                <xsl:attribute name="lang">
                                    <xsl:value-of select="$transLang"/>
                                </xsl:attribute>
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="$transLang"/>
                                </xsl:attribute>
                                <xsl:text>　〜〜</xsl:text>
                                <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                                <xsl:text>〜〜</xsl:text>
                            </span>
                        </xsl:if>
                    </h1>
                    <xsl:apply-templates select="db:mediaobject"/>
                </body>
            </html>
    </xsl:result-document>
</xsl:template>
<xsl:template match="db:bridgehead">
    <hr/>
</xsl:template>
<xsl:template match="db:date">
    <xsl:copy-of select="text()"/>
</xsl:template>
<xsl:template match="db:caption">
    <figcaption>
        <xsl:copy-of select="db:literallayout/text()"/>
        <xsl:if test="db:literallayout/db:foreignphrase">
            <span>
                <xsl:attribute name="lang">
                    <xsl:value-of select="db:literallayout/db:foreignphrase/@xml:lang"/>
                </xsl:attribute>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="db:literallayout/db:foreignphrase/@xml:lang"/>
                </xsl:attribute>
                <xsl:text>　〜〜</xsl:text>
                <xsl:copy-of select="db:literallayout/db:foreignphrase/text()"/>
                <xsl:text>〜〜</xsl:text>
            </span>
        </xsl:if>
    </figcaption>    
</xsl:template>
<xsl:template match="db:citetitle"><i><xsl:copy-of select="text()"/></i></xsl:template>
<xsl:template match="db:footnote">
    <xsl:variable name="noteNumber" select="1 + count(preceding::*[name() = 'footnote'])"/>
    <sup>
        <a id="s{$noteNumber}" href="#n{$noteNumber}" epub:type="noteref">
            <xsl:value-of select="$noteNumber"></xsl:value-of>
        </a>
    </sup>
</xsl:template>
<xsl:template match="db:emphasis"><em><xsl:copy-of select="text()"/></em></xsl:template>
<xsl:template match="db:index">
    <xsl:variable name="indexNumber" select="1 + count(preceding-sibling::*[name() = 'index'])"/>
    <!--  XHTML file for the index -->
    <xsl:result-document href="index{$indexNumber}.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8" include-content-type="no">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <head>
                <title>
                    <xsl:value-of select="db:title/text()"/>
                </title>
                <link href="../Styles/sgc-index.css" type="text/css" rel="stylesheet"/>
            </head>
            <body>
                <h1>
                    <xsl:attribute name="class">sgc-index-title</xsl:attribute>
                    <xsl:copy-of select="db:title/text()"/>
                    <xsl:if test="db:title/db:foreignphrase">
                        <span>
                            <xsl:attribute name="lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:text>　〜〜</xsl:text>
                            <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                            <xsl:text>〜〜</xsl:text>
                        </span>
                    </xsl:if>
                </h1>
                <ul>
                    <xsl:apply-templates select="db:indexentry"/>
                </ul>
            </body>
        </html>
    </xsl:result-document>
</xsl:template>
<xsl:template match="db:indexentry">
    <xsl:variable name="linkEnd" select="db:primaryie/db:link/@linkend" />
    <xsl:variable name="targetNode" select="//*[@xml:id=$linkEnd][1]"/>
    <xsl:variable name="partNum" select="1+count($targetNode/ancestor-or-self::db:part[1]/preceding-sibling::*[name() = 'part'])"/>
    <xsl:variable name="chapterNum" select="1+count($targetNode/ancestor-or-self::db:chapter[1]/preceding-sibling::*[name() = 'chapter'])"/>
    <li>
        <span>
            <a>
                <xsl:if test="$targetNode">
                    <xsl:attribute name="href">
                        <xsl:text>part</xsl:text>
                        <xsl:value-of select="$partNum"/>
                        <xsl:text>chapter</xsl:text>
                        <xsl:value-of select="$chapterNum"/>
                        <xsl:text>.xhtml#</xsl:text>
                        <xsl:value-of select="$linkEnd"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:copy-of select="db:primaryie/db:link/text()"/>
                <xsl:if test="db:primaryie/db:link/db:foreignphrase">
                    <span>
                        <xsl:attribute name="lang">
                            <xsl:value-of select="db:primaryie/db:link/db:foreignphrase/@xml:lang"/>
                        </xsl:attribute>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="db:primaryie/db:link/db:foreignphrase/@xml:lang"/>
                        </xsl:attribute>
                        <xsl:text>　〜〜</xsl:text>
                        <xsl:copy-of select="db:primaryie/db:link/db:foreignphrase/text()"/>
                        <xsl:text>〜〜</xsl:text>
                    </span>
                </xsl:if>
            </a>
        </span>
    </li>
</xsl:template>
<xsl:template match="/db:book/db:info">
<xsl:result-document href="frontmatter.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8" include-content-type="no">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <head>
                <title>Notice</title>
                <link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
            </head>
            <body>
                <h1>
                    <xsl:attribute name="style">text-align:center</xsl:attribute>
                    <xsl:copy-of select="/db:book/db:title/text()"/>
                    <xsl:if test="/db:book/db:title/db:foreignphrase">
                        <span>
                            <xsl:attribute name="lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:text>　〜〜</xsl:text>
                            <xsl:copy-of select="/db:book/db:title/db:foreignphrase/text()"/>
                            <xsl:text>〜〜</xsl:text>
                        </span>
                    </xsl:if>
                </h1>
                <xsl:apply-templates select="db:abstract"/>
                <xsl:apply-templates select="db:printhistory"/>
                <xsl:call-template name="credit"/>
            </body>
        </html>
    </xsl:result-document>
</xsl:template>
<xsl:template match="db:link">
    <a>
        <xsl:attribute name="href" select="@xlink:href"/>
        <xsl:copy-of select="text()"/>
    </a>
</xsl:template>
<xsl:template match="db:literallayout">
    <details>
        <xsl:if test="@xml:id">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"></xsl:value-of>
            </xsl:attribute>
        </xsl:if> 
        <summary>
            <xsl:apply-templates select="text()|node() except db:foreignphrase"/>
        </summary>
        <p>
            <xsl:attribute name="lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates select="db:foreignphrase/text()|db:foreignphrase/node()"/>
        </p>
    </details>
</xsl:template>
<xsl:template match="db:para"><!--  For footnotes -->
    <xsl:apply-templates/>
</xsl:template>
<xsl:template match="db:printhistory">
        <h3>
            <xsl:text>Éditions de référence</xsl:text>
            <span>
                <xsl:attribute name="lang">
                    <xsl:value-of select="$transLang"/>
                </xsl:attribute>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="$transLang"/>
                </xsl:attribute>
                <xsl:text>　〜〜参考版〜〜</xsl:text>
            </span>
        </h3>
        <p>
           <xsl:apply-templates select="db:simpara/text()|db:simpara/node() except db:simpara/db:foreignphrase"/>
        </p>
        <p>
            <xsl:attribute name="lang">
                <xsl:value-of select="$transLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$transLang"/>
            </xsl:attribute>
            <xsl:apply-templates select="db:simpara/db:foreignphrase/text()|db:simpara/db:foreignphrase/node()"/>
        </p>
</xsl:template><!-- printhistory -->
<xsl:template match="db:mediaobject">
    <figure>
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="db:imageobject/db:imagedata/@fileref"></xsl:value-of>
            </xsl:attribute>
        </img>
        <xsl:apply-templates select="db:caption"/>
    </figure>
</xsl:template>
<xsl:template match="db:title"><!--  For chapters -->
    <h2>
        <xsl:copy-of select="text()"/>
        <xsl:if test="db:foreignphrase">
        <span>
            <xsl:attribute name="lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:text>　〜〜</xsl:text>
            <xsl:copy-of select="db:foreignphrase/text()"/>
            <xsl:text>〜〜</xsl:text>
        </span>
        </xsl:if>
     </h2>
</xsl:template>
<xsl:template match="its:ruby">
    <ruby>
        <xsl:copy-of select="its:rb/text()"/>
        <rp>（</rp>
        <rt>
            <xsl:copy-of select="its:rt/text()"/>
        </rt>
        <rp>）</rp>
    </ruby>
</xsl:template>
<xsl:template match="text()"><!-- Add non-breaking spaces and replace New Line character with br tag -->
    <xsl:variable name="sub1" select="replace(., ' !', '&amp;#160;!')"/>
    <xsl:variable name="sub2" select="replace($sub1, ' :', '&amp;#160;:')"/>
    <xsl:variable name="sub3" select="replace($sub2, ' ;', '&amp;#160;;')"/>
    <xsl:variable name="sub4" select="replace($sub3, ' ;', '&amp;#160;?')"/>
    <xsl:variable name="sub5" select="replace($sub4, ' …', '&amp;#160;…')"/>
    <xsl:value-of select="replace($sub5, '&#10;', '&lt;br/&gt;')" disable-output-escaping="yes"/>
 </xsl:template>

<xsl:template match="/db:book">
    <xsl:apply-templates/>
</xsl:template>
<xsl:template match="db:part">
    <xsl:variable name="partNumber" select="1 + count(preceding-sibling::*[name() = 'part'])"/>
    <!--  XHTML file for the beginning of the part, including the 1st chapter -->
    <xsl:result-document href="part{$partNumber}chapter1.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8" include-content-type="no">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <head>
                <title>
                    <xsl:value-of select="db:title/text()"/>
                </title>
                <link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
            </head>
            <body>
                <h1>
                    <xsl:copy-of select="db:title/text()"/>
                    <xsl:if test="db:title/db:foreignphrase">
                        <span>
                            <xsl:attribute name="lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:text>　〜〜</xsl:text>
                            <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                            <xsl:text>〜〜</xsl:text>
                        </span>
                    </xsl:if>
                </h1>
                <xsl:apply-templates select="db:chapter[1]/*"/>
                <xsl:call-template name="footnotes">
                    <xsl:with-param name="partNum" select="$partNumber"/>
                    <xsl:with-param name="chapterNum" select="1"/>
                </xsl:call-template>
            </body>
        </html>
    </xsl:result-document>
    <xsl:for-each select="db:chapter">
        <!--  XHTML file for each remaining chapter in the part -->
        <xsl:if test="position()>1" >
            <xsl:result-document href="part{$partNumber}chapter{position()}.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8" include-content-type="no">
                <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                <html>
                    <xsl:attribute name="lang">
                        <xsl:value-of select="$originLang"/>
                    </xsl:attribute>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="$originLang"/>
                    </xsl:attribute>
                    <head>
                        <title>
                            <xsl:value-of select="db:title/text()"/>
                        </title>
                        <link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
                    </head>
                    <body>
                        <xsl:apply-templates/>
                        <xsl:call-template name="footnotes">
                            <xsl:with-param name="partNum" select="$partNumber"/>
                            <xsl:with-param name="chapterNum" select="position()"/>
                        </xsl:call-template>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:if>
    </xsl:for-each>
</xsl:template>
<xsl:template match="db:simpara">
    <xsl:apply-templates/>
</xsl:template>
<xsl:template name="credit">
    <h3>
        <xsl:text>Crédits　</xsl:text>
        <span>
            <xsl:attribute name="lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:text>〜〜クレジット〜〜</xsl:text>
        </span>
    </h3>
    <p>
        <xsl:text>Auteur : </xsl:text>
        <xsl:value-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:firstname/its:ruby/its:rb/text()"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:surname/its:ruby/its:rb/text()"/>
        <xsl:value-of select="'&lt;br/&gt;'" disable-output-escaping="yes"/>
        <xsl:text>Traducteur : </xsl:text>
        <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:firstname/its:ruby/its:rb/text()"/>
        <xsl:text> </xsl:text><xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:surname/its:ruby/its:rb/text()"/>
        <xsl:value-of select="'&lt;br/&gt;'" disable-output-escaping="yes"/>
        <xsl:text>Photo : </xsl:text><xsl:apply-templates select="/db:book/db:info/db:cover/db:mediaobject/db:caption/db:simpara"/>
        <xsl:text>, par </xsl:text>
        <xsl:copy-of select="/db:book/db:info/db:cover/db:mediaobject/db:info/db:author/db:personname/its:ruby/its:rb/text()"/>  
    </p>
    <p>
        <xsl:attribute name="lang">
            <xsl:value-of select="$transLang"/>
        </xsl:attribute>
        <xsl:attribute name="xml:lang">
            <xsl:value-of select="$transLang"/>
        </xsl:attribute>
        <xsl:text>作者：</xsl:text>
        <xsl:copy-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:firstname/its:ruby/its:rt/text()"/>
        <xsl:text>・</xsl:text>
        <xsl:copy-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:surname/its:ruby/its:rt/text()"/>
        <xsl:value-of select="'&lt;br/&gt;'" disable-output-escaping="yes"/>
        <xsl:text>翻訳者：</xsl:text>
        <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:surname/its:ruby/its:rt/text()" />
        <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:firstname/its:ruby/its:rt/text()" />
        <xsl:value-of select="'&lt;br/&gt;'" disable-output-escaping="yes"/>
        <xsl:text>表紙の写真家：</xsl:text>
        <xsl:copy-of select="/db:book/db:info/db:cover/db:mediaobject/db:info/db:author/db:personname/its:ruby/its:rt/text()"/>
    </p>
</xsl:template>
<!--  List of footnotes at the end of each file -->
<xsl:template name="footnotes">
    <xsl:param name="partNum" />
    <xsl:param name="chapterNum" />
    <xsl:for-each select="/db:book/db:part[$partNum]/db:chapter[$chapterNum]//db:footnote">
        <xsl:if test="position()=1">
            <br/>
            <hr/>
            <br/>
        </xsl:if> 
        <aside id="n{position()}" epub:type="footnote" >
			<p>
                <xsl:if test="name(..)='foreignphrase'">
                    <xsl:attribute name="lang">
                        <xsl:value-of select="../@xml:lang"/>
                    </xsl:attribute>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="../@xml:lang"/>
                    </xsl:attribute>
                </xsl:if> 
				<xsl:value-of select="position()"/>
				<xsl:text>. </xsl:text>
				<xsl:apply-templates/>
                <xsl:text> </xsl:text>
                <a epub:type="noteref" href="#s{position()}">
                    <xsl:if test="name(..)='foreignphrase'">
                        <xsl:if test="../@xml:lang='ja'">
                            <xsl:text>本文に戻る</xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="name(..)!='foreignphrase'">
                        <xsl:text>Retour au texte</xsl:text>
                    </xsl:if>
                </a>
            </p>
        </aside>
    </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
