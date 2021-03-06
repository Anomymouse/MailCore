<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ix="http://developer.iconara.net/ixns"
                version="1.0">

	<xsl:output method="xml"
	            indent="yes"
	          encoding="UTF-8"
	    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
	/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:text>MailCore Framework</xsl:text>
					<xsl:if test="/html/body/h1[1]">
						<xsl:text>: </xsl:text>
						<xsl:value-of select="/html/body/h1[1]"/>
					</xsl:if>
				</title>

				<link href="doxygen.css" rel="stylesheet" type="text/css" />
				<link href="styles.css" rel="stylesheet" type="text/css" />
				<link href="documentation.css" rel="stylesheet" type="text/css" />
			</head>
			<body>				
				<xsl:apply-templates />
				
				<div class="horizontal-rule copyright">
                    Copyright &#169; Matt Ronge, <a href="http://www.mronge.com">http://www.mronge.com</a>
                    <br/>
					Documentation generated by <a href="http://www.doxygen.org">doxygen</a>, 
					Custom XSL and CSS thanks to Theo Hultberg / Iconara, 
					<a href="http://developer.iconara.net">http://developer.iconara.net</a><br/>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/html">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="/html/head">
		<!-- discard -->
	</xsl:template>
	
	<xsl:template match="body">
		<div class="menu">
			<a href="index.html">Introduction</a>
			<br/>
			<xsl:call-template name="insert-classes" />
		</div>
		<div class="content">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="img">
		<div class="image-container">
			<!--
			TODO: how to do this properly, without causing an infinite loop? 
			      might work with a loop over the attributes and xsl:element and xsl:attribute
			-->
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>			<!--
			<img src="{@src}" alt="{@alt}" width="{@width}" height="{@height}" />
			-->
		</div>
	</xsl:template>
	
	<xsl:template match="hr">
		<div class="horizontal-rule"><xsl:text> </xsl:text></div>
	</xsl:template>
	
	<xsl:template name="insert-classes">
		<xsl:apply-templates select="document('menu.xml')/ix:menu" />
	</xsl:template>
	
	<xsl:template match="ix:menu">
		<xsl:for-each select="ix:section">
			<h3><xsl:value-of select="ix:title[1]" /></h3>
			<ul>
				<xsl:for-each select="ix:class|ix:protocol|ix:category|ix:group">
					<li><xsl:apply-templates select="." /></li>
				</xsl:for-each>
			</ul>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="ix:class">
		<a href="interface{text()}.html"><xsl:value-of select="text()"/></a>
	</xsl:template>
	
	<xsl:template match="ix:protocol">
		<a href="protocol{text()}-p.html"><xsl:value-of select="text()"/></a>
	</xsl:template>
	
	<xsl:template match="ix:category">
		<a href="category{@class}({text()}).html">
			<xsl:value-of select="@class"/>
			<xsl:text> ( </xsl:text>
			<xsl:value-of select="text()"/>
			<xsl:text> ) </xsl:text>
		</a>
	</xsl:template>
	
	<xsl:template match="ix:group">
		<a href="group__{text()}.html"><xsl:value-of select="text()"/></a>
	</xsl:template>

	
	<xsl:template match="node()|@*" priority="-1">
		<!-- identity template, this copies all other nodes as they are -->
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>