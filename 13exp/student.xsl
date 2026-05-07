<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html"/>
   <xsl:template match="/">
      <html>
      <head>
          <meta charset="UTF-8"/>
          <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
          <title>Student Records</title>
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
                  max-width: 900px;
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

              .stats-bar {
                  display: flex;
                  justify-content: center;
                  gap: 30px;
                  margin-bottom: 30px;
                  flex-wrap: wrap;
              }

              .stat-item {
                  background: rgba(255, 255, 255, 0.15);
                  backdrop-filter: blur(10px);
                  padding: 20px 30px;
                  border-radius: 16px;
                  text-align: center;
                  color: white;
              }

              .stat-value {
                  font-size: 2rem;
                  font-weight: 700;
                  display: block;
              }

              .stat-label {
                  font-size: 0.9rem;
                  opacity: 0.9;
                  text-transform: uppercase;
                  letter-spacing: 0.5px;
              }

              .table-wrapper {
                  background: white;
                  border-radius: 20px;
                  padding: 30px;
                  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
              }

              table {
                  width: 100%;
                  border-collapse: separate;
                  border-spacing: 0;
                  font-size: 0.95rem;
              }

              caption {
                  font-size: 1.4rem;
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

              .rollno {
                  background: #e0e7ff;
                  color: #4338ca;
                  padding: 6px 12px;
                  border-radius: 8px;
                  font-weight: 600;
                  font-size: 0.9rem;
              }

              .marks {
                  font-weight: 700;
                  font-size: 1.1rem;
              }

              .marks-excellent {
                  color: #059669;
              }

              .nickname {
                  color: #7c3aed;
                  font-style: italic;
              }

              .filter-info {
                  text-align: center;
                  margin-top: 20px;
                  padding: 15px;
                  background: #fef3c7;
                  border-radius: 10px;
                  color: #92400e;
                  font-size: 0.95rem;
              }
          </style>
      </head>
      <body>
          <div class="container">
              <header>
                  <h1>Student Records</h1>
                  <p>Academic Performance Dashboard</p>
              </header>

              <div class="stats-bar">
                  <div class="stat-item">
                      <span class="stat-value"><xsl:value-of select="count(class/student)"/></span>
                      <span class="stat-label">Total Students</span>
                  </div>
                  <div class="stat-item">
                      <span class="stat-value"><xsl:value-of select="count(class/student[marks >= 90])"/></span>
                      <span class="stat-label">Distinction</span>
                  </div>
                  <div class="stat-item">
                      <span class="stat-value"><xsl:value-of select="format-number(sum(class/student/marks) div count(class/student), '0.0')"/></span>
                      <span class="stat-label">Class Average</span>
                  </div>
              </div>

              <div class="table-wrapper">
                  <table>
                      <caption>Students with Distinction (Marks 90+)</caption>
                      <thead>
                          <tr>
                              <th>Roll No</th>
                              <th>First Name</th>
                              <th>Last Name</th>
                              <th>Nickname</th>
                              <th>Marks</th>
                          </tr>
                      </thead>
                      <tbody>
                          <xsl:for-each select="class/student">
                              <xsl:sort select="marks" data-type="number" order="descending"/>
                              <xsl:if test="marks >= 90">
                                  <tr>
                                      <td><span class="rollno"><xsl:value-of select="@rollno"/></span></td>
                                      <td><xsl:value-of select="firstname"/></td>
                                      <td><xsl:value-of select="lastname"/></td>
                                      <td><span class="nickname"><xsl:value-of select="nickname"/></span></td>
                                      <td><span class="marks marks-excellent"><xsl:value-of select="marks"/>%</span></td>
                                  </tr>
                              </xsl:if>
                          </xsl:for-each>
                      </tbody>
                  </table>
                  <div class="filter-info">
                      Showing students with 90+ marks only. Total distinction holders: <xsl:value-of select="count(class/student[marks >= 90])"/>
                  </div>
              </div>
          </div>
      </body>
      </html>
   </xsl:template>
</xsl:stylesheet>