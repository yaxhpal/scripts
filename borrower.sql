SELECT borrowers.cardnumber, borrowers.surname, borrowers.firstname, borrowers.email,
borrowers.emailpro, borrowers.B_email, borrowers.phone, borrowers.mobile, borrowers.daterenew,
borrowers.dateexpiry, borrowers.categorycode
FROM
borrowers
WHERE borrowers.branchcode = <<Branch Code>>
AND   borrowers.dateexpiry BETWEEN <<Expried Date From>> AND <<Expried Date To>>
AND daterenew NOT BETWEEN <<Renew date from>> AND <<Renew date to>>
ORDER BY 1;



SELECT borrowers.cardnumber, borrowers.surname, borrowers.firstname, borrowers.email,
borrowers.emailpro, borrowers.B_email, borrowers.phone, borrowers.mobile, borrowers.daterenew,
borrowers.dateexpiry, borrowers.categorycode
FROM
borrowers
WHERE borrowers.branchcode = <<Branch Code>>
AND   borrowers.dateexpiry BETWEEN CAST(<<Expried Date From>> AS DATE) AND CAST(<<Expried Date To>> AS DATE)
AND daterenew NOT BETWEEN CAST(<<Renew Date From>> AS DATE) AND CAST(<<Renew Date To>> AS DATE)
ORDER BY 1;


SELECT borrowers.cardnumber, borrowers.surname, borrowers.firstname, borrowers.email,
borrowers.emailpro, borrowers.B_email, borrowers.phone, borrowers.mobile, borrowers.daterenew,
borrowers.dateexpiry, borrowers.categorycode
FROM
borrowers
WHERE borrowers.branchcode = 'DL'
AND   borrowers.dateexpiry BETWEEN CAST('2011-01-01' AS DATE) AND CAST('2012-01-01' AS DATE)
AND daterenew NOT BETWEEN CAST('2011-06-01' AS DATE) AND CAST('2011-12-31' AS DATE)
ORDER BY 1;
