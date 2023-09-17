<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook" xmlns:its="http://www.w3.org/2005/11/its" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:x="adobe:ns:meta/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xmp="http://ns.adobe.com/xap/1.0/" xmlns:pdf="http://ns.adobe.com/pdf/1.3/" exclude-result-prefixes="db xsl its xlink x rdf dc xmp pdf" version="2.0">
    <xsl:namespace-alias stylesheet-prefix="fo" result-prefix="#default" />
    <xsl:variable name="originLang" select="/db:book/@xml:lang" /> <!-- Language of the original document -->
    <xsl:variable name="transLang" select="/db:book/db:title[1]/db:foreignphrase[1]/@xml:lang" /> <!-- Language of the translated document -->
    <xsl:variable name="englishFont" select="'Inter'" />
    <!--xsl:variable name="englishFont" select="'Helvetica, sans-serif, SansSerif'" /-->
    <xsl:variable name="japaneseFont" select="'BIZ UDPMincho'" /> 
    <xsl:template name="frontmatter-title"><!-- Specific attributes for block titles in the front matter -->
        <xsl:attribute name="font-size">1.2em</xsl:attribute>
        <xsl:attribute name="line-height">1.7em</xsl:attribute>
        <xsl:attribute name="margin-top">5mm</xsl:attribute>
        <!--xsl:attribute name="margin-bottom">5mm</xsl:attribute-->
    </xsl:template> 
    <xsl:template name="origin-lang-attributes"><!-- Block specific attributes related to the language of the original document -->
        <xsl:attribute name="xml:lang" select="$originLang"/> 
        <xsl:choose>
            <xsl:when test="$originLang = 'ja'">
                <xsl:attribute name="font-family">
                    <xsl:value-of select="$japaneseFont" />
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="font-family">
                    <xsl:value-of select="$englishFont" />
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="trans-lang-attributes"><!-- Block specific attributes related to the language of the original document -->
        <xsl:attribute name="xml:lang" select="$transLang"/> 
        <xsl:choose>
            <xsl:when test="$transLang = 'ja'">
                <xsl:attribute name="font-family">
                    <xsl:value-of select="'BIZ UDPMincho'" />
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="font-family">
                    <xsl:value-of select="'Helvetica, sans-serif, SansSerif'" />
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:variable name="pageWidth" select="'297'" /><!-- unit = millimeter -->
    <xsl:variable name="lateralMargin" select="'15'" />
    <xsl:variable name="centralMargin" select="'25'" />
    <xsl:variable name="topMargin" select="'10'" /><!-- Above the part title in the page header -->
    <xsl:variable name="bottomMargin" select="'10'" /><!-- Below the page number in the page footer -->
    <xsl:variable name="coverColor" select="'#EEE8B8'" />
    <xsl:template match="element() | comment() | processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="db:abstract">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="font-size">1.2em</xsl:attribute>
                    <xsl:attribute name="line-height">2em</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes" />
                    <xsl:text>Résumé</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes" />
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:copy-of select="db:para/text()"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="font-size">1.2em</xsl:attribute>
                    <xsl:attribute name="line-height">2em</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes" />
                    <xsl:text>あらすじ</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes" />
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:copy-of select="db:para/db:foreignphrase/text()"/>
                </xsl:element><!-- block -->
            </xsl:element><!--  table-cell -->
        </xsl:element><!--  table-row -->
    </xsl:template>
        <xsl:template match="db:printhistory">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:call-template name="frontmatter-title" />
                    <xsl:call-template name="origin-lang-attributes" />
                    <xsl:text>Éditions de référence</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes" />
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:apply-templates select="db:simpara/text()|db:simpara/node() except db:simpara/db:foreignphrase"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:call-template name="frontmatter-title" />
                    <xsl:call-template name="trans-lang-attributes" />
                    <xsl:text>参考版</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes" />
                    <xsl:apply-templates select="db:simpara/db:foreignphrase/text()|db:simpara/db:foreignphrase/node()"/>
                </xsl:element><!-- block -->
            </xsl:element><!--  table-cell -->
        </xsl:element><!--  table-row -->
    </xsl:template>
    <xsl:template match="db:appendix">
        <xsl:element name="page-sequence" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="master-reference">bookpage</xsl:attribute>
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page header -->
                <xsl:attribute name="flow-name">bookpage-header</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <!--xsl:call-template name="font-attribute"><xsl:with-param name="tag" select="db:title"/></xsl:call-template-->
                                        <xsl:call-template name="origin-lang-attributes" />
                                        <xsl:copy-of select="db:title/text()"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="trans-lang-attributes" />
                                        <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--  static content for page header -->
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page footer -->
                <xsl:attribute name="flow-name">bookpage-footer</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="origin-lang-attributes" />
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="trans-lang-attributes" />
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--  static content for page footer -->
            <xsl:element name="flow" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="flow-name">bookpage-body</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:apply-templates select="db:title"/>
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
                <xsl:apply-templates select="db:mediaobject"/>
            </xsl:element><!--flow-->
        </xsl:element><!--page-sequence-->
    </xsl:template>
    <xsl:template match="db:author">
        <xsl:apply-templates select="db:personname"/>
    </xsl:template>
    <xsl:template match="db:authorgroup">
        <xsl:apply-templates select="db:author"/>
    </xsl:template>
    <xsl:template match="db:bridgehead">
        <!--fo:hr/-->
    </xsl:template>
    <xsl:template match="db:chapter">
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="page-break-after">always</xsl:attribute>
                <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="table-layout">fixed</xsl:attribute>
                    <xsl:attribute name="width">100%</xsl:attribute>
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                    </xsl:element><!--  table-column -->
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                    </xsl:element><!--  table-column -->
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                    </xsl:element><!--  table-column -->
                    <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:apply-templates/>
                    </xsl:element><!--  table-body -->
                </xsl:element><!-- table -->
        </xsl:element><!-- block -->
    </xsl:template>
    <xsl:template match="db:citetitle">
    <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:copy-of select="text()"/>
     </xsl:element>
    </xsl:template>
    <xsl:template match="db:date">
     <xsl:copy-of select="text()"/>
    </xsl:template>
    <xsl:template match="db:emphasis">
        <!-- Add dots above the Japanese text -->
        <xsl:call-template name="insert-dot">
            <xsl:with-param name="text" select="."/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="db:index">
        <xsl:element name="page-sequence" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="master-reference">bookpage</xsl:attribute>
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page header -->
                <xsl:attribute name="flow-name">bookpage-header</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="origin-lang-attributes"/>
                                        <xsl:copy-of select="db:title/text()"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="trans-lang-attributes"/>
                                        <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element>
            <!--  static content for page header -->
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page footer -->
                <xsl:attribute name="flow-name">bookpage-footer</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--  static content for page footer -->
            <xsl:element name="flow" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="flow-name">bookpage-body</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:apply-templates select="db:title"/>
                            <xsl:apply-templates select="db:indexentry"/>
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--flow-->
        </xsl:element><!--page-sequence-->
    </xsl:template><!--  End of the index template -->
    <xsl:template match="db:indexentry">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top">1em</xsl:attribute>
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="text-align-last">justify</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="internal-destination"><xsl:value-of select="db:primaryie/db:link/@linkend"/></xsl:attribute>
                        <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:value-of select="db:primaryie/db:link/text()"/>
                        </xsl:element><!-- Inline -->
                        <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                        </xsl:element><!-- leader -->
                        <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="ref-id"><xsl:value-of select="db:primaryie/db:link/@linkend"/></xsl:attribute>
                        </xsl:element><!-- page-number-citation -->
                    </xsl:element><!-- basic link -->
                </xsl:element><!-- block -->
            </xsl:element><!-- table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!-- table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top">1em</xsl:attribute>
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="text-align-last">justify</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="internal-destination">
                            <xsl:value-of select="db:primaryie/db:link/@linkend"/>
                        </xsl:attribute>
                        <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:value-of select="db:primaryie/db:link/db:foreignphrase/text()"/>
                        </xsl:element><!-- Inline -->
                        <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                        </xsl:element><!-- leader -->
                        <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="ref-id">
                                <xsl:value-of select="db:primaryie/db:link/@linkend"/>
                            </xsl:attribute>
                        </xsl:element><!-- page-number-citation -->
                    </xsl:element><!-- basic link -->
                </xsl:element><!-- block -->
            </xsl:element><!-- table-cell -->
        </xsl:element><!-- table-row -->
    </xsl:template><!-- End of the indexentry template -->

    <xsl:template name="insert-dot">
        <xsl:param name="text"/>
        <xsl:if test="string-length($text) &gt; 0"><!-- Recursion condition -->
        <!--  Iterate for each character of the emphasized text -->
            <xsl:element name="inline-container" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="baseline-shift">0.45em</xsl:attribute>
                <xsl:attribute name="alignment-baseline">text-before-edge</xsl:attribute>
                <xsl:attribute name="inline-progression-dimension">1em</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"><!-- Dot -->
                    <xsl:attribute name="font-size">0.5em</xsl:attribute>
                    <xsl:attribute name="text-align">center</xsl:attribute>
                    <xsl:attribute name="line-height">0.5em</xsl:attribute>
                    <xsl:attribute name="keep-together">always</xsl:attribute>
                    <xsl:text>•</xsl:text>
                </xsl:element><!-- End Dot-->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"><!-- Text -->
                    <xsl:attribute name="text-align">center</xsl:attribute>
                    <xsl:attribute name="line-height">1.4em</xsl:attribute>
                    <xsl:copy-of select="substring($text,1,1)"/>
                </xsl:element><!-- End Text -->
            </xsl:element><!-- End inline-container -->
            <xsl:call-template name="insert-dot"><!--  recursion -->
                <xsl:with-param name="text" select="substring($text,2)"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template match="db:firstname">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="db:footnote"><!-- Translator's notes are expected to be marked with the attribute role="translator-note" -->
        <xsl:variable name="noteNumber" select="1 + count(preceding::*[name() = 'footnote'])"/>
        <xsl:element name="footnote" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="font-size">75%</xsl:attribute>
                <xsl:attribute name="baseline-shift">super</xsl:attribute>
                <xsl:value-of select="$noteNumber"></xsl:value-of>
            </xsl:element><!-- inline -->
            <xsl:element name="footnote-body" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="font-size">0.8em</xsl:attribute>
                    <xsl:if test="name(..)='foreignphrase'">
                        <xsl:attribute name="start-indent">
                            <xsl:value-of select="((number($pageWidth) + number($centralMargin)) div 2) - number($lateralMargin)"/>mm</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="name(..)!='foreignphrase'">
                        <xsl:attribute name="end-indent"><xsl:value-of select="((number($pageWidth) + number($centralMargin)) div 2) - number($lateralMargin)"/>mm</xsl:attribute>
                    </xsl:if>
                    <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="font-family"><xsl:value-of select="$englishFont"></xsl:value-of></xsl:attribute>
                        <xsl:value-of select="$noteNumber"/>
                        <xsl:text>. </xsl:text>
                    </xsl:element> <!--  inline -->
                    <xsl:apply-templates/>
                    <xsl:text> </xsl:text>
                </xsl:element><!-- block --> 
            </xsl:element><!-- footnote-body --> 
        </xsl:element><!-- footnote -->
    </xsl:template>
    <xsl:template match="db:link">
        <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="text-decoration">underline</xsl:attribute>
            <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="external-destination" select="@xlink:href"/>
                <xsl:copy-of select="text()"/>
            </xsl:element> <!-- Basic-link element -->
        </xsl:element> <!-- Inline element -->
    </xsl:template>
    <xsl:template match="db:literallayout">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:if test="@xml:id"> 
                        <xsl:attribute name="id" select="@xml:id"/>
                    </xsl:if>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:apply-templates select="text()|node() except db:foreignphrase"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
             </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:attribute name="line-height">1.9em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:apply-templates select="db:foreignphrase/text()|db:foreignphrase/node()"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->    
        </xsl:element><!--  table-row -->
    </xsl:template>
    <xsl:template match="db:info">
    </xsl:template>
    <xsl:template match="db:mediaobject">
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="page-break-after">always</xsl:attribute>
            <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="table-layout">fixed</xsl:attribute>
                <xsl:attribute name="width">100%</xsl:attribute>
                <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                </xsl:element><!--  table-column -->
                <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                </xsl:element><!--  table-column -->
                <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                </xsl:element><!--  table-column -->
                <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="height">160mm</xsl:attribute>
                        <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="display-align">center</xsl:attribute>
                            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:attribute name="text-align">center</xsl:attribute>
                                    <xsl:element name="external-graphic" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="src">url(<xsl:value-of select="substring-before(db:imageobject/db:imagedata/@fileref, '.')"/>-fr.<xsl:value-of select="substring-after(db:imageobject/db:imagedata/@fileref, '.')"/>)</xsl:attribute>
                                        <xsl:attribute name="content-width">65mm</xsl:attribute>
                                    </xsl:element>
                                </xsl:element><!-- block for the image -->
                                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:attribute name="text-align">center</xsl:attribute>
                                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                                    <xsl:value-of select="db:caption/db:literallayout/text()"/>
                                </xsl:element><!-- block for the caption -->
                            </xsl:element><!-- composite block for the image and caption  -->
                        </xsl:element><!-- table-cell -->
                        <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                            <!--  Empty cell in the middle -->
                            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                        </xsl:element><!--  table-cell -->
                        <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="display-align">center</xsl:attribute>
                            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:attribute name="text-align">center</xsl:attribute>
                                    <xsl:element name="external-graphic" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="src">url(<xsl:value-of select="substring-before(db:imageobject/db:imagedata/@fileref, '.')"/>-ja.<xsl:value-of select="substring-after(db:imageobject/db:imagedata/@fileref, '.')"/>)</xsl:attribute>
                                        <xsl:attribute name="content-width">65mm</xsl:attribute>
                                    </xsl:element><!-- external graphic -->
                                </xsl:element><!-- block for the image -->
                                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:attribute name="text-align">center</xsl:attribute>
                                    <xsl:call-template name="trans-lang-attributes"/>
                                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                                    <xsl:attribute name="line-height">1.9em</xsl:attribute>
                                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                                    <xsl:value-of select="db:caption/db:literallayout/db:foreignphrase/text()"/>
                                </xsl:element><!-- block for the caption -->
                            </xsl:element><!-- composite block image + caption -->
                        </xsl:element><!-- table-cell -->
                    </xsl:element><!-- table row -->
                </xsl:element><!--  table-body -->
            </xsl:element><!-- table -->
        </xsl:element><!-- block -->
    </xsl:template>
    <xsl:template match="db:para">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="db:part">
        <xsl:element name="page-sequence" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="master-reference">bookpage</xsl:attribute>
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for footnotes -->
                <xsl:attribute name="flow-name">xsl-footnote-separator</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-bottom">5mm</xsl:attribute>
                    <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="leader-pattern">rule</xsl:attribute>
                        <xsl:attribute name="leader-length">100%</xsl:attribute>
                        <xsl:attribute name="rule-style">solid</xsl:attribute>
                        <xsl:attribute name="rule-thickness">0.5pt</xsl:attribute>
                    </xsl:element><!-- leader --> 
                </xsl:element><!-- block -->
            </xsl:element><!--  static content -->
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page header -->
                <xsl:attribute name="flow-name">bookpage-header</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                    <!--xsl:attribute name="margin-bottom">5mm</xsl:attribute-->
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="origin-lang-attributes" />
                                        <xsl:copy-of select="db:title/text()"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="trans-lang-attributes" />
                                        <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--  static content for page header -->
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page footer -->
                <xsl:attribute name="flow-name">bookpage-footer</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="origin-lang-attributes"/>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="trans-lang-attributes"/>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element> <!--  static content for page footer -->
            <xsl:element name="flow" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="flow-name">bookpage-body</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:apply-templates select="db:title"/>
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
                <xsl:apply-templates select="db:chapter"/>
            </xsl:element><!--flow-->
        </xsl:element><!--page-sequence-->
    </xsl:template>
    <xsl:template match="db:personname">
        <xsl:choose>
            <xsl:when test="db:firstname">
                <xsl:apply-templates select="db:firstname"/><xsl:apply-templates select="db:surname"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="db:simpara">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="db:surname">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="db:title">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="font-size">1.2em</xsl:attribute>
                    <xsl:attribute name="line-height">3em</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:choose>
                        <xsl:when test="name(..)='appendix'">
                            <xsl:attribute name="text-align">center</xsl:attribute>
                            <xsl:attribute name="id" select="concat('a', 1 + count(../preceding-sibling::*[name() = 'appendix']))"/>
                        </xsl:when>
                        <xsl:when test="name(..)='chapter'">
                            <xsl:attribute name="margin-top">15mm</xsl:attribute>
                            <xsl:attribute name="margin-bottom">10mm</xsl:attribute>
                            <xsl:attribute name="id" select="concat('p', 1 + count(../../preceding-sibling::*[name() = 'part']),'ch',1 + count(../preceding-sibling::*[name() = 'chapter']))"/>
                        </xsl:when>
                        <xsl:when test="name(..)='index'">
                            <xsl:attribute name="margin-top">15mm</xsl:attribute>
                            <xsl:attribute name="text-align">center</xsl:attribute>
                            <xsl:attribute name="id" select="concat('i', 1 + count(../preceding-sibling::*[name() = 'index']))"/>
                        </xsl:when>
                        <xsl:when test="name(..)='part'">
                            <xsl:attribute name="margin-top">15mm</xsl:attribute>
                            <xsl:attribute name="text-align">center</xsl:attribute>
                            <xsl:attribute name="id" select="concat('p', 1 + count(../preceding-sibling::*[name() = 'part']))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="text-align">center</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:copy-of select="text()"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="font-size">1.2em</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:choose>
                        <xsl:when test="name(..)='appendix'">
                            <xsl:attribute name="text-align">center</xsl:attribute>
                        </xsl:when>
                        <xsl:when test="name(..)='chapter'">
                            <xsl:attribute name="margin-bottom">10mm</xsl:attribute>
                            <xsl:attribute name="margin-top">15mm</xsl:attribute>
                        </xsl:when>
                        <xsl:when test="name(..)='index'">
                            <xsl:attribute name="margin-top">15mm</xsl:attribute>
                            <xsl:attribute name="text-align">center</xsl:attribute>
                        </xsl:when>
                        <xsl:when test="name(..)='part'">
                            <xsl:attribute name="margin-top">15mm</xsl:attribute>
                            <xsl:attribute name="text-align">center</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="text-align">center</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="line-height">3em</xsl:attribute>
                    <xsl:copy-of select="db:foreignphrase/text()"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->
        </xsl:element><!--  table-row -->
    </xsl:template>
    <xsl:template match="its:ruby">
    <!--xsl:template match="its:ruby[preceding-sibling::node()[1][self::text()[ends-with(., 'く')]]]"-->
        <xsl:element name="inline-container" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="baseline-shift">0.5em</xsl:attribute>
            <xsl:attribute name="alignment-baseline">text-before-edge</xsl:attribute>
            <xsl:attribute name="inline-progression-dimension"><!-- Japanese characters are 1em wide, whereas latin character are about 0.5em wide on average -->
                <xsl:if test="name(..)='foreignphrase'"><xsl:value-of select="string-length(its:rb/text())"></xsl:value-of>em</xsl:if>
                <xsl:if test="name(..)!='foreignphrase'"><xsl:value-of select="(number(string-length(its:rb/text())) div 2)"></xsl:value-of>em</xsl:if>
            </xsl:attribute>
            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"><!-- Furigana -->
                <xsl:attribute name="font-size">0.5em</xsl:attribute>
                <xsl:attribute name="text-align">center</xsl:attribute>
                <xsl:attribute name="line-height">0.5em</xsl:attribute>
                <xsl:attribute name="keep-together">always</xsl:attribute>
                <xsl:attribute name="font-family"><xsl:value-of select="$japaneseFont"></xsl:value-of></xsl:attribute>
                <xsl:copy-of select="its:rt/text()"/>
            </xsl:element><!-- End Furigana-->
            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"><!-- Difficult kanji(s) -->
                <xsl:attribute name="text-align">center</xsl:attribute>
                <xsl:attribute name="line-height">1.4em</xsl:attribute>
                <xsl:copy-of select="its:rb/text()"/>
            </xsl:element><!-- End Difficult kanji(s)-->
        </xsl:element><!-- End inline-container -->
         <!--fo:ruby>
            <xsl:copy-of select="its:rb/text()"/>
            <fo:rp>（</fo:rp>
            <fo:rt>
                <xsl:copy-of select="its:rt/text()"/>
            </fo:rt>
            <fo:rp>）</fo:rp>
        </fo:ruby-->
    </xsl:template>
    <xsl:template match="text()">
        <xsl:variable name="sub1" select="replace(., ' !', '&#160;!')"/>
        <xsl:variable name="sub2" select="replace($sub1, ' :', '&#160;:')"/>
        <xsl:variable name="sub3" select="replace($sub2, ' ;', '&#160;;')"/>
        <xsl:variable name="sub4" select="replace($sub3, ' ;', '&#160;?')"/>
        <xsl:value-of select="replace($sub4, ' …', '&#160;…')"/>
    </xsl:template>

    <xsl:template match="/db:book">
        <xsl:element name="root" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="font-family"><xsl:value-of select="$englishFont"></xsl:value-of></xsl:attribute>
            <xsl:attribute name="font-size">12pt</xsl:attribute>
            <xsl:element name="layout-master-set" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="simple-page-master" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="page-width"><xsl:value-of select="$pageWidth"/>mm</xsl:attribute>
                    <xsl:attribute name="page-height">210mm</xsl:attribute>
                    <xsl:attribute name="master-name">cover_page</xsl:attribute>
                    <xsl:element name="region-body" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="region-name">cover-body</xsl:attribute>
                        <xsl:attribute name="margin-top">2em + <xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                        <xsl:attribute name="margin-bottom"><xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                        <xsl:attribute name="background-color"><xsl:value-of select="$coverColor" /></xsl:attribute>
                    </xsl:element><!--region-body-->
                    <xsl:element name="region-before" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="region-name">coverpage-header</xsl:attribute>
                        <xsl:attribute name="background-color"><xsl:value-of select="$coverColor" /></xsl:attribute>
                        <xsl:attribute name="extent">2em + <xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                    </xsl:element><!-- region-before -->
                    <xsl:element name="region-after" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="region-name">coverpage-footer</xsl:attribute>
                        <xsl:attribute name="background-color"><xsl:value-of select="$coverColor" /></xsl:attribute>
                        <xsl:attribute name="extent"><xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                    </xsl:element><!-- region-after -->
                </xsl:element><!--simple-page-master / cover_page -->
                <xsl:element name="simple-page-master" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-right"><xsl:value-of select="$lateralMargin"/>mm</xsl:attribute>
                    <xsl:attribute name="margin-left"><xsl:value-of select="$lateralMargin"/>mm</xsl:attribute>
                    <xsl:attribute name="page-width"><xsl:value-of select="$pageWidth"/>mm</xsl:attribute>
                    <xsl:attribute name="page-height">210mm</xsl:attribute>
                    <xsl:attribute name="master-name">first_page</xsl:attribute>
                    <xsl:element name="region-body" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="region-name">bookpage-body</xsl:attribute>
                        <xsl:attribute name="margin-top">2em + <xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                        <xsl:attribute name="margin-bottom"><xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                    </xsl:element><!--region-body-->
                    <xsl:element name="region-after" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="region-name">bookpage-footer</xsl:attribute>
                        <xsl:attribute name="extent">2em + <xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                    </xsl:element><!--region-after-->
                </xsl:element><!--simple-page-master / first_page -->
                <xsl:element name="simple-page-master" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-right">15mm</xsl:attribute>
                    <xsl:attribute name="margin-left">15mm</xsl:attribute>
                    <xsl:attribute name="page-width"><xsl:value-of select="$pageWidth"/>mm</xsl:attribute>
                    <xsl:attribute name="page-height">210mm</xsl:attribute>
                <xsl:attribute name="master-name">other_pages</xsl:attribute>
                <xsl:element name="region-body" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="region-name">bookpage-body</xsl:attribute>
                    <xsl:attribute name="margin-top">2em + <xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                    <xsl:attribute name="margin-bottom">2em + <xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                </xsl:element><!--region-body-->
                <xsl:element name="region-before" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="region-name">bookpage-header</xsl:attribute>
                    <xsl:attribute name="extent">2em + <xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                </xsl:element><!--region-before-->
                <xsl:element name="region-after" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="region-name">bookpage-footer</xsl:attribute>
                    <xsl:attribute name="extent">2em + <xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                </xsl:element><!--region-after-->
            </xsl:element><!--simple-page-master / other_pages -->
            <xsl:element name="page-sequence-master" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="master-name">cover</xsl:attribute>
                <xsl:element name="single-page-master-reference" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="master-reference">cover_page</xsl:attribute>
                </xsl:element><!-- single-page-master-reference -->
            </xsl:element><!-- page-sequence-master for the cover -->
            <xsl:element name="page-sequence-master" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="master-name">frontmatter</xsl:attribute>
                <xsl:element name="single-page-master-reference" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="master-reference">first_page</xsl:attribute>
                </xsl:element><!-- single-page-master-reference -->
            </xsl:element><!-- page-sequence-master for the front matter -->
            <xsl:element name="page-sequence-master" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="master-name">bookpage</xsl:attribute>
                <xsl:element name="single-page-master-reference" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="master-reference">first_page</xsl:attribute>
                </xsl:element><!-- single-page-master-reference -->
                <xsl:element name="repeatable-page-master-reference" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="master-reference">other_pages</xsl:attribute>
                </xsl:element><!-- repeatable-page-master-reference -->
            </xsl:element><!-- page-sequence-master for the content matter -->
            </xsl:element><!--layout-master-set-->
            <xsl:call-template name="declarations"/>
            <xsl:call-template name="bookmark-tree"/>
            <xsl:call-template name="cover"/>
            <xsl:call-template name="frontmatter"/>
            <xsl:apply-templates select="db:part"/>
            <xsl:apply-templates select="db:appendix"/>
            <xsl:apply-templates select="db:index"/>
            <xsl:call-template name="table-of-contents"/> 
        </xsl:element><!-- root -->
    </xsl:template>
    <xsl:template name="declarations">
        <xsl:element name="declarations" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="x:xmpmeta" namespace="adobe:ns:meta/">
                <xsl:element name="rdf:RDF" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                    <xsl:element name="rdf:Description" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                        <xsl:element name="dc:title" namespace="http://purl.org/dc/elements/1.1/">
                            <xsl:element name="rdf:Alt" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                                <xsl:element name="rdf:li" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                                    <xsl:attribute name="xml:lang">x-default</xsl:attribute>
                                    <xsl:value-of select="/db:book/db:title/db:foreignphrase/text()"/>
                                    <xsl:text> | </xsl:text>
                                    <xsl:value-of select="/db:book/db:title/text()"/>
                                </xsl:element><!--rdf:li element-->
                            </xsl:element><!--rdf:Alt element-->
                        </xsl:element><!--dc title element-->
                        <xsl:element name="dc:creator" namespace="http://purl.org/dc/elements/1.1/">
                            <xsl:element name="rdf:Seq" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                                <xsl:element name="rdf:li" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:firstname/its:ruby/its:rb/text()"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:surname/its:ruby/its:rb/text()"/>
                                    <xsl:text> | </xsl:text>
                                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:surname/its:ruby/its:rt/text()"/>
                                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:firstname/its:ruby/its:rt/text()"/>
                                </xsl:element><!--rdf:li element-->
                            </xsl:element><!--rdf:Seq element-->
                        </xsl:element><!--dc creator element-->
                        <xsl:element name="dc:description" namespace="http://purl.org/dc/elements/1.1/">
                            <xsl:element name="rdf:Alt" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                                <xsl:element name="rdf:li" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                                    <xsl:attribute name="xml:lang">x-default</xsl:attribute>
                                    <xsl:value-of separator=", " select="/db:book/db:info/db:subjectset/db:subject/db:subjectterm"/>
                                </xsl:element><!--rdf:li element-->
                            </xsl:element><!--rdf:Alt element-->
                        </xsl:element><!--dc description (i.e. subject) element-->
                    </xsl:element><!--Description element for Dublin Core properties-->
                    <xsl:element name="rdf:Description" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                        <xsl:element name="xmp:CreatorTool" namespace="http://ns.adobe.com/xap/1.0/">
                            <xsl:text>dbk2fo.xsl</xsl:text>
                        </xsl:element><!--xmp CreatorTool element-->
                    </xsl:element><!--Description element for XMP metadata -->
                    <xsl:element name="rdf:Description" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                        <xsl:element name="pdf:Keywords" namespace="http://ns.adobe.com/pdf/1.3/">
                            <xsl:value-of separator=", " select="/db:book/db:info/db:keywordset/db:keyword"/>
                        </xsl:element><!--pdf Keyword element-->
                    </xsl:element><!--Description element for PDF metadata -->
                </xsl:element><!--rdf element-->
            </xsl:element><!--xmpmeta element-->
        </xsl:element><!--declarations-->
    </xsl:template>
    <xsl:template name="bookmark-tree">
        <xsl:element name="bookmark-tree" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="bookmark" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="internal-destination">cover</xsl:attribute>
                    <xsl:element name="bookmark-title" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:value-of select="/db:book/db:title/text()"/>
                        <xsl:text>　〜〜</xsl:text>
                        <xsl:copy-of select="/db:book/db:title/db:foreignphrase/text()"/>
                        <xsl:text>〜〜</xsl:text>
                    </xsl:element> <!-- cover bookmark-title -->
            </xsl:element> <!-- cover bookmark -->
            <xsl:for-each select="/db:book/db:part">
                <xsl:variable name="partNum" select="position()"/>
                <xsl:element name="bookmark" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="internal-destination">p<xsl:value-of select="$partNum"/></xsl:attribute>
                    <xsl:element name="bookmark-title" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:value-of select="db:title/text()"/>
                        <xsl:text>　〜〜</xsl:text>
                        <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                        <xsl:text>〜〜</xsl:text>
                    </xsl:element> <!-- part bookmark-title -->
                    <xsl:for-each select="db:chapter">
                        <xsl:variable name="chapterNum" select="position()"/>
                        <xsl:element name="bookmark" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="internal-destination">p<xsl:value-of select="$partNum"/>ch<xsl:value-of select="$chapterNum"/></xsl:attribute>
                            <xsl:element name="bookmark-title" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:value-of select="db:title/text()"/>
                                <xsl:text>　〜〜</xsl:text>
                                <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                                <xsl:text>〜〜</xsl:text>
                            </xsl:element> <!-- chapter bookmark-title -->
                        </xsl:element> <!-- chapter bookmark -->
                    </xsl:for-each> <!-- Loop on chapters -->
                </xsl:element> <!-- part bookmark -->
            </xsl:for-each> <!-- Loop on parts -->
            <xsl:for-each select="/db:book/db:appendix">
                <xsl:variable name="appendixNum" select="position()"/>
                <xsl:element name="bookmark" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="internal-destination">a<xsl:value-of select="$appendixNum"/></xsl:attribute>
                    <xsl:element name="bookmark-title" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:value-of select="db:title/text()"/>
                        <xsl:text>　〜〜</xsl:text>
                        <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                        <xsl:text>〜〜</xsl:text>
                    </xsl:element><!-- part bookmark-title -->
                </xsl:element><!-- appendix bookmark -->
            </xsl:for-each><!-- Loop on indexes -->
            <xsl:for-each select="/db:book/db:index">
                <xsl:variable name="indexNum" select="position()"/>
                <xsl:element name="bookmark" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="internal-destination">i<xsl:value-of select="$indexNum"/></xsl:attribute>
                    <xsl:element name="bookmark-title" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:value-of select="db:title/text()"/>
                        <xsl:text>　〜〜</xsl:text>
                        <xsl:copy-of select="db:title/db:foreignphrase/text()"/>
                        <xsl:text>〜〜</xsl:text>
                    </xsl:element><!-- part bookmark-title -->
                </xsl:element><!-- appendix bookmark -->
            </xsl:for-each><!-- Loop on indexes -->
        </xsl:element> <!-- bookmark-tree -->
    </xsl:template>
    <xsl:template name="cover">
        <xsl:element name="page-sequence" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="master-reference">cover</xsl:attribute>
            <xsl:element name="flow" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="flow-name">cover-body</xsl:attribute>
                <xsl:attribute name="margin-top"><xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="id">cover</xsl:attribute>
                    <xsl:attribute name="table-layout">fixed</xsl:attribute>
                    <xsl:attribute name="width">100%</xsl:attribute>
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="number($lateralMargin)"/>mm</xsl:attribute>
                    </xsl:element><!-- table-column for left margin -->
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                    </xsl:element><!--  table-column for left page -->
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                    </xsl:element><!--  table-column for central margin -->
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                    </xsl:element><!--  table-column for right page -->
                    <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="column-width"><xsl:value-of select="number($lateralMargin)"/>mm</xsl:attribute>
                    </xsl:element><!-- table-column for right margin -->
                    <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:attribute name="column-number">4</xsl:attribute>
                                <xsl:call-template name="cover-title" />
                                <xsl:call-template name="cover-author" />
                                <xsl:call-template name="cover-image" />
                                <xsl:call-template name="cover-subtitle" />
                            </xsl:element><!--  table-cell -->
                        </xsl:element><!--  table-row -->
                    </xsl:element><!--  table-body -->
                </xsl:element><!-- table -->
            </xsl:element><!--flow-->
        </xsl:element><!--page-sequence-->
    </xsl:template>
    <xsl:template name="cover-title">
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="text-align">center</xsl:attribute>
            <xsl:attribute name="font-size">200%</xsl:attribute>
            <xsl:call-template name="origin-lang-attributes"/>
            <xsl:value-of select="/db:book/db:title/text()" />
        </xsl:element><!--Block for the original title -->
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="text-align">center</xsl:attribute>
            <xsl:attribute name="font-size">200%</xsl:attribute>
            <xsl:call-template name="trans-lang-attributes"/>
            <xsl:value-of select="/db:book/db:title/db:foreignphrase/text()" />
        </xsl:element><!--Block for the translated title -->
    </xsl:template>
    <xsl:template name="cover-author">
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="text-align">right</xsl:attribute>
            <xsl:attribute name="font-size">150%</xsl:attribute>
            <xsl:attribute name="margin-top">10mm</xsl:attribute>
            <xsl:call-template name="origin-lang-attributes" /><!-- By definition, the author wrote in the original language of the document -->
            <xsl:apply-templates select="/db:book/db:info/*[contains(name(),'author')]" />
        </xsl:element>
    </xsl:template>
    <xsl:template name="cover-image">
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="external-graphic" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="src">url(cover.jpg)</xsl:attribute>
                <xsl:attribute name="width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                <xsl:attribute name="content-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template name="cover-subtitle">
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="text-align">left</xsl:attribute>
            <xsl:attribute name="font-size">120%</xsl:attribute>
            <xsl:call-template name="trans-lang-attributes" />
            <xsl:value-of select="/db:book/db:subtitle/db:foreignphrase/text()" />
        </xsl:element><!-- Block for the subtitle in the translation language -->
        <xsl:if test="/db:book/db:subtitle/db:foreignphrase/@xml:lang='ja'">
            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="text-align">left</xsl:attribute>
                <xsl:attribute name="font-size">120%</xsl:attribute>
                <xsl:call-template name="trans-lang-attributes"/>
                <xsl:text>翻訳家：</xsl:text>
                <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:surname/its:ruby/its:rt" />
                <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:firstname/its:ruby/its:rt" />
            </xsl:element>
        </xsl:if><!--  Name of the translator -->
        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="margin-top">10mm</xsl:attribute>
            <xsl:attribute name="text-align">center</xsl:attribute>
            <xsl:attribute name="font-size">120%</xsl:attribute>
            <xsl:call-template name="origin-lang-attributes"/>
            <xsl:value-of select="/db:book/db:subtitle/text()" />
        </xsl:element><!-- Block for the title in the original language of the document -->
    </xsl:template>
    <xsl:template name="frontmatter">
        <xsl:element name="page-sequence" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="master-reference">bookpage</xsl:attribute>
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page footer -->
                <xsl:attribute name="flow-name">bookpage-footer</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$bottomMargin"/>mm</xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--  static content for page footer -->
            <xsl:element name="flow" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="flow-name">bookpage-body</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:apply-templates select="/db:book/db:title"/>
                            <xsl:apply-templates select="/db:book/db:info/db:abstract"/>
                            <xsl:apply-templates select="/db:book/db:info/db:printhistory"/>
                            <xsl:call-template name="credits" />
                            <xsl:call-template name="publisher" />
                            <xsl:apply-templates select="/db:book/db:info/db:biblioid"/>
                            <xsl:apply-templates select="/db:book/db:info/db:legalnotice"/>
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--flow-->
        </xsl:element><!--page-sequence-->
    </xsl:template>
    <xsl:template name="publisher">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:call-template name="frontmatter-title" />
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:text>Éditeur</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="text-align-last">justify</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:value-of select="/db:book/db:info/db:publisher/db:publishername/text()"/>
                    </xsl:element><!-- inline --> 
                    <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="leader-pattern">space</xsl:attribute>
                    </xsl:element>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:email/text()"/>
                </xsl:element><!--  block publishername -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:street/text()"/>
                    <xsl:text>, </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:postcode/text()"/>
                    <xsl:text> </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:city/text()"/>
                    <xsl:text>, </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:country/text()"/>
                </xsl:element><!--  block publisher address -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:call-template name="frontmatter-title" />
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:text>出版社</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="text-align-last">justify</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:value-of select="/db:book/db:info/db:publisher/db:publishername/text()"/>
                    </xsl:element><!-- inline --> 
                    <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="leader-pattern">space</xsl:attribute>
                    </xsl:element>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:email/text()"/>
                </xsl:element><!--  block publishername -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:street/text()"/>
                    <xsl:text>, </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:postcode/text()"/>
                    <xsl:text> </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:city/text()"/>
                    <xsl:text>, </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:publisher/db:address/db:country/text()"/>
                </xsl:element><!--  block publisher address -->
            </xsl:element><!--  table-cell -->
        </xsl:element><!--  table-row -->
    </xsl:template>
    <xsl:template match="db:biblioid">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="margin-top">5mm</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="text-align">center</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:copy-of select="upper-case(@class)"/>
                    <xsl:text> </xsl:text>
                    <xsl:copy-of select="text()"/>
                </xsl:element><!-- block -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="margin-top">5mm</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="text-align">center</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:copy-of select="upper-case(@class)"/>
                    <xsl:text> </xsl:text>
                    <xsl:copy-of select="text()"/>
                </xsl:element><!-- block -->
            </xsl:element><!--  table-cell -->
        </xsl:element><!--  table-row -->
    </xsl:template>
    <xsl:template match="db:legalnotice">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="text-align">center</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:copy-of select="db:para/text()"/>
                </xsl:element><!-- block -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="text-align">center</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:choose>
                        <xsl:when test="db:para/db:foreignphrase">
                            <xsl:copy-of select="db:para/db:foreignphrase/text()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="db:para/text()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element><!-- block -->
            </xsl:element><!--  table-cell -->
        </xsl:element><!--  table-row -->
    </xsl:template>
    <xsl:template name="credits">
        <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:call-template name="frontmatter-title" />
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:text>Crédits</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:call-template name="origin-lang-attributes"/>
                    <xsl:text>Auteur : </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:firstname/its:ruby/its:rb/text()"/>
                    <xsl:text> </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:surname/its:ruby/its:rb/text()"/>
                    <xsl:text>&#xA;Traducteur : </xsl:text>
                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:firstname/its:ruby/its:rb/text()" />
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:surname/its:ruby/its:rb/text()" />
                    <xsl:text>&#xA;Photo : </xsl:text>
                     <xsl:apply-templates select="/db:book/db:info/db:cover/db:mediaobject/db:caption/db:simpara"/>
                    <!--xsl:copy-of select="/db:book/db:info/db:cover/db:mediaobject/db:caption/text()"/ -->
                    <xsl:text>, par </xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:cover/db:mediaobject/db:info/db:author/db:personname/its:ruby/its:rb/text()"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <!--  Empty cell in the middle -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
            </xsl:element><!--  table-cell -->
            <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:call-template name="frontmatter-title" />
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:text>クレジット</xsl:text>
                </xsl:element><!--  block -->
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="line-height">1.3em</xsl:attribute>
                    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
                    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
                    <xsl:call-template name="trans-lang-attributes"/>
                    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
                    <xsl:text>作者：</xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:firstname/its:ruby/its:rt/text()"/>
                    <xsl:text>・</xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:authorgroup/db:author/db:personname/db:surname/its:ruby/its:rt/text()"/>
                    <xsl:text>&#xA;翻訳者：</xsl:text>
                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:surname/its:ruby/its:rt/text()" />
                    <xsl:value-of select="/db:book/db:info/db:authorgroup/db:othercredit[@class='translator']/db:personname/db:firstname/its:ruby/its:rt/text()" />
                    <xsl:text>&#xA;表紙の写真家：</xsl:text>
                    <xsl:copy-of select="/db:book/db:info/db:cover/db:mediaobject/db:info/db:author/db:personname/its:ruby/its:rt/text()"/>
                </xsl:element><!--  block -->
            </xsl:element><!--  table-cell -->
        </xsl:element><!--  table-row -->
    </xsl:template>
    <xsl:template name="table-of-contents">
        <xsl:element name="page-sequence" namespace="http://www.w3.org/1999/XSL/Format">
            <xsl:attribute name="master-reference">bookpage</xsl:attribute>
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format"><!-- static content for the page header -->
                <xsl:attribute name="flow-name">bookpage-header</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$topMargin"/>mm</xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element> <!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="origin-lang-attributes"/>
                                        <xsl:text>Table des matières</xsl:text>
                                    </xsl:element><!--  Title block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="trans-lang-attributes"/>
                                        <xsl:text>目次</xsl:text>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--  static content for page header -->
            <xsl:element name="static-content" namespace="http://www.w3.org/1999/XSL/Format">
                <!-- static content for the page footer -->
                <xsl:attribute name="flow-name">bookpage-footer</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:attribute name="margin-top"><xsl:value-of select="$bottomMargin"/>mm
                    </xsl:attribute>
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm
                            </xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm
                            </xsl:attribute>
                        </xsl:element> <!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm
                            </xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:call-template name="origin-lang-attributes"/>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="font-size">75%</xsl:attribute>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:call-template name="trans-lang-attributes"/>
                                        <xsl:element name="page-number" namespace="http://www.w3.org/1999/XSL/Format"/>
                                    </xsl:element><!--  block -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--  static content for page footer -->
            <xsl:element name="flow" namespace="http://www.w3.org/1999/XSL/Format">
                <xsl:attribute name="flow-name">bookpage-body</xsl:attribute>
                <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                    <xsl:element name="table" namespace="http://www.w3.org/1999/XSL/Format">
                        <xsl:attribute name="table-layout">fixed</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="$centralMargin"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-column" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:attribute name="column-width"><xsl:value-of select="(number($pageWidth) - number($centralMargin) - number($lateralMargin) - number($lateralMargin)) div 2"/>mm</xsl:attribute>
                        </xsl:element><!--  table-column -->
                        <xsl:element name="table-body" namespace="http://www.w3.org/1999/XSL/Format">
                            <xsl:element name="table-row" namespace="http://www.w3.org/1999/XSL/Format">
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:attribute name="font-size">1.2em</xsl:attribute>
                                        <xsl:attribute name="line-height">3em</xsl:attribute>
                                        <xsl:attribute name="margin-top">15mm</xsl:attribute>
                                        <xsl:call-template name="origin-lang-attributes">
                                        </xsl:call-template>
                                        <xsl:text>Table des matières</xsl:text>
                                    </xsl:element><!--  Title block -->
                                    <xsl:for-each select="/db:book/db:part">
                                        <xsl:variable name="partNum" select="position()"/>
                                        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                            <xsl:attribute name="line-height">1.35em</xsl:attribute>
                                            <xsl:attribute name="margin-top">1em</xsl:attribute> 
                                            <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                            <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="internal-destination">p<xsl:value-of select="$partNum"/></xsl:attribute>
                                                <xsl:value-of select="db:title/text()"/>
                                                <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                </xsl:element><!-- leader -->
                                                <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="ref-id">p<xsl:value-of select="$partNum"/></xsl:attribute>
                                                </xsl:element><!-- page-number-citation -->
                                            </xsl:element><!-- basic link -->
                                        </xsl:element><!-- part block -->
                                        <xsl:for-each select="db:chapter">
                                            <xsl:variable name="chapterNum" select="position()"/>
                                            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                                <xsl:attribute name="start-indent">3em</xsl:attribute>
                                                <xsl:attribute name="line-height">1.35em</xsl:attribute>
                                                <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="internal-destination">p<xsl:value-of select="$partNum"/>ch<xsl:value-of select="$chapterNum"/></xsl:attribute>
                                                    <xsl:value-of select="db:title/text()"/>
                                                    <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                        <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                    </xsl:element><!-- leader -->
                                                    <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                        <xsl:attribute name="ref-id">p<xsl:value-of select="$partNum"/>ch<xsl:value-of select="$chapterNum"/></xsl:attribute>
                                                    </xsl:element><!-- page-number-citation -->
                                                </xsl:element><!-- basic-link -->
                                            </xsl:element> <!-- chapter block -->
                                        </xsl:for-each><!-- Loop on chapters -->
                                    </xsl:for-each><!-- Loop on parts -->
                                    <xsl:for-each select="/db:book/db:appendix">
                                        <xsl:variable name="appendixNum" select="position()"/>
                                        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                            <xsl:attribute name="line-height">1.35em</xsl:attribute>
                                            <xsl:attribute name="margin-top">1em</xsl:attribute>
                                            <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                            <xsl:call-template name="origin-lang-attributes"/>
                                            <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="internal-destination">a<xsl:value-of select="$appendixNum"/></xsl:attribute>
                                                <xsl:value-of select="db:title/text()"/>
                                                <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                </xsl:element><!-- leader -->
                                                <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="ref-id">a<xsl:value-of select="$appendixNum"/></xsl:attribute>
                                                </xsl:element><!-- page-number-citation -->
                                            </xsl:element><!-- basic link -->
                                        </xsl:element><!-- part block -->
                                    </xsl:for-each><!-- Loop on indexes -->
                                    <xsl:for-each select="/db:book/db:index">
                                        <xsl:variable name="indexNum" select="position()"/>
                                        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                            <xsl:attribute name="line-height">1.35em</xsl:attribute>
                                            <xsl:attribute name="margin-top">1em</xsl:attribute>
                                            <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                            <xsl:call-template name="origin-lang-attributes"/>
                                            <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="internal-destination">i<xsl:value-of select="$indexNum"/></xsl:attribute>
                                                <xsl:value-of select="db:title/text()"/>
                                                <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                </xsl:element><!-- leader -->
                                                <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="ref-id">i<xsl:value-of select="$indexNum"/></xsl:attribute>
                                                </xsl:element><!-- page-number-citation -->
                                            </xsl:element><!-- basic link -->
                                        </xsl:element><!-- part block -->
                                    </xsl:for-each><!-- Loop on indexes -->
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <!--  Empty cell in the middle -->
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format"> </xsl:element>
                                </xsl:element><!--  table-cell -->
                                <xsl:element name="table-cell" namespace="http://www.w3.org/1999/XSL/Format">
                                    <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                        <xsl:call-template name="trans-lang-attributes"/>
                                        <xsl:attribute name="text-align">center</xsl:attribute>
                                        <xsl:attribute name="font-size">1.2em</xsl:attribute>
                                        <xsl:attribute name="line-height">3em</xsl:attribute>
                                        <xsl:attribute name="margin-top">15mm</xsl:attribute>
                                        <xsl:text>目次</xsl:text>
                                    </xsl:element><!-- Title block -->
                                    <xsl:for-each select="/db:book/db:part">
                                        <xsl:variable name="partNum" select="position()"/>
                                        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                            <xsl:call-template name="trans-lang-attributes"/>
                                            <xsl:attribute name="margin-top">1em</xsl:attribute>
                                            <xsl:call-template name="trans-lang-attributes"/>
                                            <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                            <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="internal-destination">p<xsl:value-of select="$partNum"/></xsl:attribute>
                                                <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:value-of select="db:title/db:foreignphrase/text()"/>
                                                </xsl:element><!-- inline --> 
                                                <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                </xsl:element><!-- leader -->
                                                <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="ref-id">p<xsl:value-of select="$partNum"/></xsl:attribute>
                                                </xsl:element><!-- page-number-citation -->
                                            </xsl:element><!-- basic link -->
                                        </xsl:element><!-- part block -->
                                        <xsl:for-each select="db:chapter">
                                            <xsl:variable name="chapterNum" select="position()"/>
                                            <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                                <xsl:attribute name="start-indent">3em</xsl:attribute>
                                                <xsl:call-template name="trans-lang-attributes" />
                                                <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="internal-destination">p<xsl:value-of select="$partNum"/>ch<xsl:value-of select="$chapterNum"/></xsl:attribute>
                                                    <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                                                        <xsl:value-of select="db:title/db:foreignphrase/text()"/>
                                                    </xsl:element><!-- inline -->
                                                    <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                        <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                    </xsl:element><!-- leader -->
                                                    <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                        <xsl:attribute name="ref-id">p<xsl:value-of select="$partNum"/>ch<xsl:value-of select="$chapterNum"/></xsl:attribute>
                                                    </xsl:element><!-- page-number-citation -->
                                                </xsl:element><!-- basic-link -->
                                            </xsl:element><!-- chapter block -->
                                        </xsl:for-each><!-- Loop on chapters -->
                                    </xsl:for-each><!-- Loop on parts -->
                                    <xsl:for-each select="/db:book/db:appendix">
                                        <xsl:variable name="appendixNum" select="position()"/>
                                        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                            <xsl:attribute name="margin-top">1em</xsl:attribute>
                                            <xsl:call-template name="trans-lang-attributes"/>
                                            <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                            <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="internal-destination">a<xsl:value-of select="$appendixNum"/></xsl:attribute>
                                                <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:value-of select="db:title/db:foreignphrase/text()"/>
                                                </xsl:element><!-- inline -->
                                                <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                </xsl:element><!-- leader -->
                                                <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="ref-id">a<xsl:value-of select="$appendixNum"/></xsl:attribute>
                                                </xsl:element><!-- page-number-citation -->
                                            </xsl:element><!-- basic link -->
                                        </xsl:element><!-- part block -->
                                    </xsl:for-each><!-- Loop on indexes -->
                                    <xsl:for-each select="/db:book/db:index">
                                        <xsl:variable name="indexNum" select="position()"/>
                                        <xsl:element name="block" namespace="http://www.w3.org/1999/XSL/Format">
                                            <xsl:attribute name="margin-top">1em</xsl:attribute>
                                            <xsl:call-template name="trans-lang-attributes" />
                                            <xsl:attribute name="text-align-last">justify</xsl:attribute>
                                            <xsl:element name="basic-link" namespace="http://www.w3.org/1999/XSL/Format">
                                                <xsl:attribute name="internal-destination">i<xsl:value-of select="$indexNum"/></xsl:attribute>
                                                <xsl:element name="inline" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:value-of select="db:title/db:foreignphrase/text()"/>
                                                </xsl:element><!-- inline -->
                                                <xsl:element name="leader" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="leader-pattern">dots</xsl:attribute>
                                                </xsl:element><!-- leader -->
                                                <xsl:element name="page-number-citation" namespace="http://www.w3.org/1999/XSL/Format">
                                                    <xsl:attribute name="ref-id">i<xsl:value-of select="$indexNum"/></xsl:attribute>
                                                </xsl:element><!-- page-number-citation -->
                                            </xsl:element><!-- basic link -->
                                        </xsl:element><!-- part block -->
                                    </xsl:for-each><!-- Loop on indexes -->
                                </xsl:element><!--  table-cell -->
                            </xsl:element><!--  table-row -->
                        </xsl:element><!--  table-body -->
                    </xsl:element><!-- table -->
                </xsl:element><!-- block -->
            </xsl:element><!--flow-->
        </xsl:element><!--page-sequence-->
    </xsl:template>
</xsl:stylesheet>
