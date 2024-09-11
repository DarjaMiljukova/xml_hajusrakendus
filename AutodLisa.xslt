<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes" encoding="utf-8"/>

    <xsl:template match="/">
		<h3>1. Autod, mille tootmisaasta on pärast 2010. aastat</h3>
		<table border="1">
			<tr>
				<th>Mark</th>
				<th>Registreerinumber</th>
				<th>Väljastamise aasta</th>
			</tr>
			<xsl:for-each select="autod/auto[vaasta &gt; 2010]">
				<tr>
					<td>
						<xsl:value-of select="mark"/>
					</td>
					<td>
						<xsl:value-of select="registreerinumber"/>
					</td>
					<td>
						<xsl:value-of select="vaasta"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<hr></hr>
		<h3>2. Automarkid tähestikulises järjekorras, kus vaasta = 1998</h3>
		<table border="1">
			<tr>
				<th>Mark</th>
			</tr>
			<xsl:for-each select="autod/auto[vaasta = 1998]">
				<xsl:sort select="mark" order="ascending"/>
				<tr>
					<td>
						<xsl:value-of select="mark"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<hr></hr>
		<h3>Autode üldkogus xml jadas</h3>
		<br></br>
		Kasutame count() funktsiooni
		<xsl:value-of select="count(autod/auto)"/>
		<hr></hr>
		<h3>Autode üldkogus, mis on vaasta=2006</h3>
		<br></br>
		Kasutame count() funktsiooni
		<xsl:value-of select="count(autod/auto[vaasta=2006])"/>
		<hr></hr>
		<h2>1. Trüki välja (eralda komaga) auto registrinumbri numbrite osa</h2>
		<xsl:for-each select="autod/auto">
			<xsl:value-of select="substring(registreerinumber, 1, 3)"/>, 
		</xsl:for-each>
		<hr></hr>
		<h2>2. Trüki välja (eralda komaga) omaniku viimane täht</h2>
		<hr></hr>
		<xsl:for-each select="autod/auto">
			<xsl:value-of select="substring(omanik, string-length(omanik), 1)"/>, 
		</xsl:for-each>
		<hr></hr>
		<h3>3. Auto omanikud, mis sisaldavad A täht</h3>
		<hr></hr>
		<xsl:for-each select="autod/auto[contains(translate(omanik, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'a')]">
			<xsl:value-of select="omanik"/>, 
		</xsl:for-each>
		<hr></hr>
		<h3>4. Leia, mitme auto registrimärgi numbritest viimane on 2</h3>
		<ul>
			<xsl:for-each select="autod/auto[substring(translate(registreerinumber, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', ''), string-length(translate(registreerinumber, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', '')), 1) = '2']">
				<li>
					<xsl:value-of select="registreerinumber"/>
				</li>
			</xsl:for-each>
		</ul>

		<hr></hr>
		<h3>5. Teata iga registrinumbri puhul, millises kuus auto ülevaatus</h3>
		<hr></hr>
		<h3>Auto regnumbrid mis algavad 6:</h3>
		<br></br>
		Kasutame starts-with funktsiooni
		<ul>
					<xsl:for-each select="autod/auto[starts-with(registreerinumber, '6')]">
						<xsl:sort select="vaasta" order="descending"/>
			<li>
				<xsl:value-of select="concat(mark, ',', registreerinumber, ',', vaasta)"/>
			</li>
		</xsl:for-each>
		</ul>
		
		<h2>Autod tabelina</h2>
		<table border="1">
			<tr>
				<th>Reg Number</th>
				<th>Mark</th>
				<th>Väljastamise aasta</th>
				<th>Omanik</th>
				<th>Ülevaatuse kuu</th>
			</tr>
			<xsl:for-each select="autod/auto">
				<tr>
					<td>
						<xsl:value-of select="registreerinumber"/>
					</td>
					<td>
						<xsl:value-of select="mark"/>
					</td>
					<td>
						<xsl:value-of select="vaasta"/>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="contains(translate(omanik, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'a')">
								<td bgcolor="yellow">
									<xsl:value-of select="omanik"/>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td>
									<xsl:value-of select="omanik"/>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<xsl:if test="(substring(registreerinumber, 3, 1)+2)>=9">
						<td bgcolor="red">
							<xsl:value-of select="substring(registreerinumber, 3, 1)+2"/>
						</td>
					</xsl:if>
					<xsl:if test="(substring(registreerinumber, 3, 1)+2) &lt;9">
						<td bgcolor="green">
							<xsl:value-of select="substring(registreerinumber, 3, 1)+2"/>
						</td>
					</xsl:if>
					<td>
						<xsl:value-of select="substring(registreerinumber, 3, 1)+2"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
    </xsl:template>
</xsl:stylesheet>
