﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:its="http://www.w3.org/2005/11/its" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="db its xsl xhtml xlink" version="2.0">
<xsl:namespace-alias stylesheet-prefix="xhtml" result-prefix="#default" />
<xsl:variable name="mainLang" select="/db:book/@xml:lang" />
<xsl:variable name="originLang" select="/db:book/@xml:lang" /> <!-- Language of the original document -->
<xsl:variable name="transLang" select="/db:book/db:title[1]/db:foreignphrase[1]/@xml:lang" /> <!-- Language of the translated document -->
<xsl:template match="element() | comment() | processing-instruction()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>
<xsl:template match="db:abstract">
    <xhtml:h3>
        <xsl:text>Résumé　</xsl:text>
        <xhtml:span>
            <xsl:attribute name="lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:text>〜〜あらすじ〜〜</xsl:text>
        </xhtml:span>
    </xhtml:h3>
    <xhtml:p>
        <xsl:value-of select="db:para/text()"/>
    </xhtml:p>
    <xhtml:p>
            <xsl:attribute name="lang">
                <xsl:value-of select="db:para/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="db:para/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates select="db:para/db:foreignphrase/text()"/>
    </xhtml:p>
</xsl:template>
<xsl:template match="db:appendix">
    <!--  XHTML file for the appendix -->
    <xsl:result-document href="{lower-case(db:title/text())}.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xhtml:html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xhtml:head>
                <xhtml:title>
                    <xsl:value-of select="db:title/text()"/>
                </xhtml:title>
                    <xhtml:link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
                </xhtml:head>
                <xhtml:body>
                    <xhtml:h1>
                        <xsl:copy-of select="db:title/text()"/>
                        <xsl:if test="db:title/db:foreignphrase">
                            <xhtml:span>
                                <xsl:attribute name="lang">
                                    <xsl:value-of select="$transLang"/>
                                </xsl:attribute>
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="$transLang"/>
                                </xsl:attribute>
                                <xsl:text>　〜〜</xsl:text>
                                <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                                <xsl:text>〜〜</xsl:text>
                            </xhtml:span>
                        </xsl:if>
                    </xhtml:h1>
                    <xsl:apply-templates select="db:mediaobject"/>
                </xhtml:body>
            </xhtml:html>
    </xsl:result-document>
</xsl:template>
<xsl:template match="db:bridgehead">
    <xhtml:hr/>
</xsl:template>
<xsl:template match="db:date">
    <xsl:copy-of select="text()"/>
</xsl:template>
<xsl:template match="db:caption">
    <xhtml:figcaption>
        <xsl:copy-of select="db:literallayout/text()"/>
        <xsl:if test="db:literallayout/db:foreignphrase">
            <xhtml:span>
                <xsl:attribute name="lang">
                    <xsl:value-of select="db:literallayout/db:foreignphrase/@xml:lang"/>
                </xsl:attribute>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="db:literallayout/db:foreignphrase/@xml:lang"/>
                </xsl:attribute>
                <xsl:text>　〜〜</xsl:text>
                <xsl:copy-of select="db:literallayout/db:foreignphrase/text()"/>
                <xsl:text>〜〜</xsl:text>
            </xhtml:span>
        </xsl:if>
    </xhtml:figcaption>    
</xsl:template>
<xsl:template match="db:citetitle"><xhtml:i><xsl:copy-of select="text()"/></xhtml:i></xsl:template>
<xsl:template match="db:footnote">
    <xsl:variable name="noteNumber" select="1 + count(preceding::*[name() = 'footnote'])"/>
    <xhtml:sup>
        <xhtml:a id="s{$noteNumber}" href="#n{$noteNumber}" epub:type="noteref">
            <xsl:value-of select="$noteNumber"></xsl:value-of>
        </xhtml:a>
    </xhtml:sup>
</xsl:template>
<xsl:template match="db:emphasis"><xhtml:em><xsl:copy-of select="text()"/></xhtml:em></xsl:template>
<xsl:template match="db:index">
    <xsl:variable name="indexNumber" select="1 + count(preceding-sibling::*[name() = 'index'])"/>
    <!--  XHTML file for the index -->
    <xsl:result-document href="index{$indexNumber}.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xhtml:html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xhtml:head>
                <xhtml:title>
                    <xsl:value-of select="db:title/text()"/>
                </xhtml:title>
                <xhtml:link href="../Styles/sgc-index.css" type="text/css" rel="stylesheet"/>
            </xhtml:head>
            <xhtml:body>
                <xhtml:h1>
                    <xsl:attribute name="class">sgc-index-title</xsl:attribute>
                    <xsl:copy-of select="db:title/text()"/>
                    <xsl:if test="db:title/db:foreignphrase">
                        <xhtml:span>
                            <xsl:attribute name="lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:text>　〜〜</xsl:text>
                            <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                            <xsl:text>〜〜</xsl:text>
                        </xhtml:span>
                    </xsl:if>
                </xhtml:h1>
                <xhtml:ul>
                    <xsl:apply-templates select="db:indexentry"/>
                </xhtml:ul>
            </xhtml:body>
        </xhtml:html>
    </xsl:result-document>
</xsl:template>
<xsl:template match="db:indexentry">
    <xsl:variable name="linkEnd" select="db:primaryie/db:link/@linkend" />
    <xsl:variable name="targetNode" select="//*[@xml:id=$linkEnd][1]"/>
    <xsl:variable name="partNum" select="1+count($targetNode/ancestor-or-self::db:part[1]/preceding-sibling::*[name() = 'part'])"/>
    <xsl:variable name="chapterNum" select="1+count($targetNode/ancestor-or-self::db:chapter[1]/preceding-sibling::*[name() = 'chapter'])"/>
    <xhtml:li>
        <xhtml:span>
            <xhtml:a>
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
                    <xhtml:span>
                        <xsl:attribute name="lang">
                            <xsl:value-of select="db:primaryie/db:link/db:foreignphrase/@xml:lang"/>
                        </xsl:attribute>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="db:primaryie/db:link/db:foreignphrase/@xml:lang"/>
                        </xsl:attribute>
                        <xsl:text>　〜〜</xsl:text>
                        <xsl:copy-of select="db:primaryie/db:link/db:foreignphrase/text()"/>
                        <xsl:text>〜〜</xsl:text>
                    </xhtml:span>
                </xsl:if>
            </xhtml:a>
        </xhtml:span>
    </xhtml:li>
</xsl:template>
<xsl:template match="/db:book/db:info">
<xsl:result-document href="frontmatter.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xhtml:html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xhtml:head>
                <xhtml:title>Notice</xhtml:title>
                <xhtml:link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
            </xhtml:head>
            <xhtml:body>
                <xhtml:h1>
                    <xsl:attribute name="style">text-align:center</xsl:attribute>
                    <xsl:copy-of select="/db:book/db:title/text()"/>
                    <xsl:if test="/db:book/db:title/db:foreignphrase">
                        <xhtml:span>
                            <xsl:attribute name="lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:text>　〜〜</xsl:text>
                            <xsl:copy-of select="/db:book/db:title/db:foreignphrase/text()"/>
                            <xsl:text>〜〜</xsl:text>
                        </xhtml:span>
                    </xsl:if>
                </xhtml:h1>
                <xsl:apply-templates select="db:abstract"/>
                <xsl:apply-templates select="db:printhistory"/>
                <xsl:call-template name="credit"/>
            </xhtml:body>
        </xhtml:html>
    </xsl:result-document>
</xsl:template>
<xsl:template match="db:link">
    <xhtml:a>
        <xsl:attribute name="href" select="@xlink:href"/>
        <xsl:copy-of select="text()"/>
    </xhtml:a>
</xsl:template>
<xsl:template match="db:literallayout">
    <xhtml:details>
        <xsl:if test="@xml:id">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"></xsl:value-of>
            </xsl:attribute>
        </xsl:if> 
        <xhtml:summary>
            <xsl:apply-templates select="text()|node() except db:foreignphrase"/>
        </xhtml:summary>
        <xhtml:p>
            <xsl:attribute name="lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates select="db:foreignphrase/text()|db:foreignphrase/node()"/>
        </xhtml:p>
    </xhtml:details>
</xsl:template>
<xsl:template match="db:para"><!--  For footnotes -->
    <xsl:apply-templates/>
</xsl:template>
<xsl:template match="db:printhistory">
        <xhtml:h3>
            <xsl:text>Éditions de référence</xsl:text>
            <xhtml:span>
                <xsl:attribute name="lang">
                    <xsl:value-of select="$transLang"/>
                </xsl:attribute>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="$transLang"/>
                </xsl:attribute>
                <xsl:text>　〜〜参考版〜〜</xsl:text>
            </xhtml:span>
        </xhtml:h3>
        <xhtml:p>
           <xsl:apply-templates select="db:simpara/text()|db:simpara/node() except db:simpara/db:foreignphrase"/>
        </xhtml:p>
        <xhtml:p>
            <xsl:attribute name="lang">
                <xsl:value-of select="$transLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$transLang"/>
            </xsl:attribute>
            <xsl:apply-templates select="db:simpara/db:foreignphrase/text()|db:simpara/db:foreignphrase/node()"/>
        </xhtml:p>
</xsl:template><!-- printhistory -->
<xsl:template match="db:mediaobject">
    <xhtml:figure>
        <xhtml:img>
            <xsl:attribute name="src">
                <xsl:value-of select="db:imageobject/db:imagedata/@fileref"></xsl:value-of>
            </xsl:attribute>
        </xhtml:img>
        <xsl:apply-templates select="db:caption"/>
    </xhtml:figure>
</xsl:template>
<xsl:template match="db:title"><!--  For chapters -->
    <xhtml:h2>
        <xsl:copy-of select="text()"/>
        <xsl:if test="db:foreignphrase">
        <xhtml:span>
            <xsl:attribute name="lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:text>　〜〜</xsl:text>
            <xsl:copy-of select="db:foreignphrase/text()"/>
            <xsl:text>〜〜</xsl:text>
        </xhtml:span>
        </xsl:if>
     </xhtml:h2>
</xsl:template>
<xsl:template match="its:ruby">
    <xhtml:ruby>
        <xsl:copy-of select="its:rb/text()"/>
        <xhtml:rp>（</xhtml:rp>
        <xhtml:rt>
            <xsl:copy-of select="its:rt/text()"/>
        </xhtml:rt>
        <xhtml:rp>）</xhtml:rp>
    </xhtml:ruby>
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
    <xsl:result-document href="part{$partNumber}chapter1.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xhtml:html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$originLang"/>
            </xsl:attribute>
            <xhtml:head>
                <xhtml:title>
                    <xsl:value-of select="db:title/text()"/>
                </xhtml:title>
                <xhtml:link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
            </xhtml:head>
            <xhtml:body>
                <xhtml:h1>
                    <xsl:copy-of select="db:title/text()"/>
                    <xsl:if test="db:title/db:foreignphrase">
                        <xhtml:span>
                            <xsl:attribute name="lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$transLang"/>
                            </xsl:attribute>
                            <xsl:text>　〜〜</xsl:text>
                            <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                            <xsl:text>〜〜</xsl:text>
                        </xhtml:span>
                    </xsl:if>
                </xhtml:h1>
                <xsl:apply-templates select="db:chapter[1]/*"/>
                <xsl:call-template name="footnotes">
                    <xsl:with-param name="partNum" select="$partNumber"/>
                    <xsl:with-param name="chapterNum" select="1"/>
                </xsl:call-template>
            </xhtml:body>
        </xhtml:html>
    </xsl:result-document>
    <xsl:for-each select="db:chapter">
        <!--  XHTML file for each remaining chapter in the part -->
        <xsl:if test="position()>1" >
            <xsl:result-document href="part{$partNumber}chapter{position()}.xhtml" method="xhtml" omit-xml-declaration="no" indent="yes" encoding="utf-8">
                <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                <xhtml:html xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="lang">
                        <xsl:value-of select="$originLang"/>
                    </xsl:attribute>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="$originLang"/>
                    </xsl:attribute>
                    <xhtml:head>
                        <xhtml:title>
                            <xsl:value-of select="db:title/text()"/>
                        </xhtml:title>
                        <xhtml:link href="../Styles/styles.css" type="text/css" rel="stylesheet"/>
                    </xhtml:head>
                    <xhtml:body>
                        <xsl:apply-templates/>
                        <xsl:call-template name="footnotes">
                            <xsl:with-param name="partNum" select="$partNumber"/>
                            <xsl:with-param name="chapterNum" select="position()"/>
                        </xsl:call-template>
                    </xhtml:body>
                </xhtml:html>
            </xsl:result-document>
        </xsl:if>
    </xsl:for-each>
</xsl:template>
<xsl:template match="db:simpara">
    <xsl:apply-templates/>
</xsl:template>
<xsl:template name="credit">
    <xhtml:h3>
        <xsl:text>Crédits　</xsl:text>
        <xhtml:span>
            <xsl:attribute name="lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="/db:book/db:title/db:foreignphrase/@xml:lang"/>
            </xsl:attribute>
            <xsl:text>〜〜クレジット〜〜</xsl:text>
        </xhtml:span>
    </xhtml:h3>
    <xhtml:p>
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
    </xhtml:p>
    <xhtml:p>
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
    </xhtml:p>
</xsl:template>
<!--  List of footnotes at the end of each file -->
<xsl:template name="footnotes">
    <xsl:param name="partNum" />
    <xsl:param name="chapterNum" />
    <xsl:for-each select="/db:book/db:part[$partNum]/db:chapter[$chapterNum]//db:footnote">
        <xsl:if test="position()=1">
            <xhtml:br/>
            <xhtml:hr/>
            <xhtml:br/>
        </xsl:if> 
        <xhtml:aside id="n{position()}" epub:type="footnote" >
			<xhtml:p>
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
                <xhtml:a epub:type="noteref" href="#s{position()}">
                    <xsl:if test="name(..)='foreignphrase'">
                        <xsl:if test="../@xml:lang='ja'">
                            <xsl:text>本文に戻る</xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="name(..)!='foreignphrase'">
                        <xsl:text>Retour au texte</xsl:text>
                    </xsl:if>
                </xhtml:a>
            </xhtml:p>
        </xhtml:aside>
    </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
