<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:template match="/">
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Music Catalog</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
        }

        header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .table-wrapper {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 0.95rem;
        }

        caption {
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 25px;
            text-align: center;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 18px 15px;
            font-weight: 600;
            text-align: left;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        th:first-child {
            border-radius: 10px 0 0 0;
        }

        th:last-child {
            border-radius: 0 10px 0 0;
        }

        td {
            padding: 16px 15px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
            color: #4a5568;
        }

        tr:hover td {
            background: #f7fafc;
        }

        tr:last-child td:first-child {
            border-radius: 0 0 0 10px;
        }

        tr:last-child td:last-child {
            border-radius: 0 0 10px 0;
        }

        .price {
            color: #059669;
            font-weight: 600;
        }

        .year {
            background: #e0e7ff;
            color: #4338ca;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .country {
            background: #fef3c7;
            color: #92400e;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Music Collection Catalog</h1>
            <p>Curated collection of classic albums</p>
        </header>

        <div class="table-wrapper">
            <table>
                <caption>Complete CD Collection</caption>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Artist</th>
                        <th>Country</th>
                        <th>Company</th>
                        <th>Price</th>
                        <th>Year</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="catalog/cd">
                    <tr>
                        <td><strong><xsl:value-of select="title"/></strong></td>
                        <td><xsl:value-of select="artist"/></td>
                        <td><span class="country"><xsl:value-of select="country"/></span></td>
                        <td><xsl:value-of select="company"/></td>
                        <td><span class="price">$<xsl:value-of select="price"/></span></td>
                        <td><span class="year"><xsl:value-of select="year"/></span></td>
                    </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>