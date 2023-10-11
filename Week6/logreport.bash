#!/bin/bash

echo "
<html>

<head>
<title>Log Report</title>
</head>

<body>
  <table>
    <tr>
    <th>IP</th>
    <th>Date/Time</th>
    <th>Page Request</th>
    <th>User Agent</th>
    </tr>" >> logreport.html

    while file= read -r line
    do
	ip=$(echo "$line" | awk '{print $1}')
	datetime=$(echo "$line" | awk -F'[][]' '{print $2}' | cut -d ' ' -f 1,2)
	pagereq=$(echo "$line" | awk -F'"' '{print $2}')
	useragent=$(echo "$line" | awk -F'"' '{print $6}')

  echo "<tr>
	<td>   "$ip"   </td>
	<td>   "$datetime"   </td>
	<td>   "$pagereq"   </td>
	<td>   "$useragent"   </td>
	</tr>" >> logreport.html
    done < mergedlogs.txt
echo "
 </table>
</body>

</html>" >> logreport.html

cp logreport.html /var/www/html/logreport.html
