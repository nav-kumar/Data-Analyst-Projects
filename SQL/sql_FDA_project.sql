use sqlproject;
select *from appdoc;
select *from appdoc where ActionType='AP';
select *from appdoctype_lookup;
select *from application;
select *from chemtypelookup;
select *from doctype_lookup;
select *from product;
select *from product_tecode;
select count(*)from regactiondate;
select *from regactiondate;
describe regactiondate;
show columns from regactiondate;
select *from reviewclass_lookup;
--------------------------------------------------------------------------------------
/*Task 1: Identifying Approval Trends
1. Determine the number of drugs approved each year and provide insights into the yearly 
trends.*/
SELECT YEAR(r.ActionDate) AS ApprovalYear, COUNT(*) AS ApprovalCount
FROM regactiondate r
join product p on p.ApplNo=r.ApplNo
where p.ProductMktStatus=1
GROUP BY YEAR(r.ActionDate)
ORDER BY ApprovalYear;

/*2. Identify the top three years that got the highest and lowest approvals, in descending and 
ascending order, respectively.*/

#DESCENDING ORDER TOP 3
SELECT YEAR(r.ActionDate) AS ApprovalYear, COUNT(*) AS ApprovalCount
FROM regactiondate r
join product p on p.ApplNo=r.ApplNo
where p.ProductMktStatus=1
GROUP BY YEAR(r.ActionDate)
ORDER BY ApprovalCount DESC
LIMIT 3;


#ASCENDING ORDER TOP 3
SELECT YEAR(r.ActionDate) AS ApprovalYear, COUNT(*) AS ApprovalCount
FROM regactiondate r
join product p on p.ApplNo=r.ApplNo
where p.ProductMktStatus=1
GROUP BY YEAR(r.ActionDate)
ORDER BY ApprovalCount ASC
limit 3;


#3-Explore Approval trends over the years based on sponsors

SELECT 
    YEAR(r.ActionDate) AS ApprovalYear, 
    a.SponsorApplicant AS Sponsor, 
    COUNT(*) AS ApprovalCount
FROM regactiondate r
JOIN Application a ON a.ApplNo = r.ApplNo 
GROUP BY YEAR(r.ActionDate), a.SponsorApplicant
ORDER BY ApprovalYear, ApprovalCount ;

/*4. Rank sponsors based on the total number of approvals they received each year between 1939 
and 1960.*/

SELECT 
    YEAR(r.ActionDate) AS ApprovalYear, 
    a.SponsorApplicant AS Sponsor, 
    COUNT(*) AS ApprovalCount,
    RANK() OVER (PARTITION BY YEAR(r.ActionDate) ORDER BY COUNT(*) DESC) AS SponsorRank
FROM regactiondate r
JOIN application a ON a.ApplNo = r.ApplNo  
WHERE YEAR(r.ActionDate) BETWEEN 1939 AND 1960
GROUP BY YEAR(r.ActionDate), a.SponsorApplicant
ORDER BY ApprovalYear, SponsorRank;

/*Task 2: Segmentation Analysis Based on Drug MarketingStatus
1. Group products based on MarketingStatus. Provide meaningful insights into the 
segmentation patterns.*/

SELECT ProductMktStatus, COUNT(*) AS ProductCount
FROM product
GROUP BY ProductMktStatus;

/*  2. Calculate the total number of applications for each MarketingStatus year-wise after the year 
2010. */

SELECT 
    YEAR(r.ActionDate) AS ApplicationYear, 
    p.ProductMktStatus, 
    COUNT(*) AS ApplicationCount
FROM regactiondate r
JOIN product p ON r.ApplNo = p.ApplNo  
WHERE YEAR(r.ActionDate) > 2010
GROUP BY YEAR(r.ActionDate), p.ProductMktStatus;

/*3. Identify the top MarketingStatus with the maximum number of applications and analyze its 
trend over time */

SELECT 
    p.ProductMktStatus, 
    COUNT(*) AS TotalApplications
FROM regactiondate r
JOIN product p ON r.ApplNo= p.ApplNo 
WHERE YEAR(r.ActionDate) > 2010
GROUP BY p.ProductMktStatus
ORDER BY TotalApplications DESC
LIMIT 1;

WITH TopStatus AS (
    SELECT p.ProductMktStatus AS TopMarketingStatus
    FROM product p
    JOIN regactiondate r ON p.ApplNo = r.ApplNo
    WHERE YEAR(r.ActionDate) > 2010
    GROUP BY p.ProductMktStatus
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
SELECT 
    YEAR(r.ActionDate) AS ApplicationYear, 
    COUNT(*) AS ApplicationCount
FROM regactiondate r
JOIN product p ON p.ApplNo = r.ApplNo
JOIN TopStatus ON p.ProductMktStatus = TopStatus.TopMarketingStatus
GROUP BY YEAR(r.ActionDate);

/*Task 3: Analyzing Products
1. Categorize Products by dosage form and analyze their distribution.*/

select *from product;
describe product;

SELECT Form, Dosage, COUNT(*) AS ProductCount
FROM product
GROUP BY Form, Dosage
ORDER BY ProductCount DESC;

/*2. Calculate the total number of approvals for each dosage form and identify the most 
successful forms.*/

SELECT ProductMktStatus, COUNT(*) AS Count
FROM product
GROUP BY ProductMktStatus
ORDER BY Count DESC;

select distinct TECode from product;
select TECode, TESequence from product_tecode;
select count(*) as nullcount from product where TECode is null;
select count(*) as Totalcount from product where TECode is NOT NULL;
select count(*) as nullcount from product_tecode where TESequence is null;
select count(*) as Totalcount from product_tecode where TECode is NOT NULL;

/*SELECT 
    YEAR(r.ActionDate) AS ApprovalYear, 
    p.Dosage, p.Form, 
    COUNT(*) AS ApprovalCount,
    RANK() OVER (PARTITION BY YEAR(r.ActionDate) ORDER BY COUNT(*) DESC) AS SuccessfulForms
FROM regactiondate r
JOIN product p ON p.ApplNo = r.ApplNo  
GROUP BY YEAR(r.ActionDate), p.Dosage, p.Form
ORDER BY ApprovalYear, SuccessfulForms;*/

SELECT p.Dosage,p.Form, COUNT(*) AS ApprovalCount
FROM product p
JOIN regactiondate r ON p.ApplNo = r.ApplNo
WHERE p.ProductMktStatus = 1
GROUP BY p.Dosage, p.Form
ORDER BY ApprovalCount DESC;

/*SELECT
  p.Form,
  p.Dosage,
  COUNT(*) AS ApprovalCount,
  ROW_NUMBER() OVER (PARTITION BY p.Dosage ORDER BY count(*) DESC) AS FormRank
FROM product p
WHERE p.ProductMktStatus = 1
GROUP BY p.Form, p.Dosage
ORDER BY p.Dosage, FormRank; */

/*3. Investigate yearly trends related to successful forms. */

SELECT
  YEAR(r.ActionDate) AS ApprovalYear,
  p.Form,
  COUNT(*) AS ApprovalCount
FROM product p
JOIN regactiondate r ON p.ApplNo = r.ApplNo
WHERE p.ProductMktStatus = '1' 
GROUP BY YEAR(r.ActionDate), p.Form
ORDER BY ApprovalYear;

/*Task 4: Exploring Therapeutic Classes and Approval Trends
1. Analyze drug approvals based on therapeutic evaluation code (TE_Code).*/

SELECT 
    YEAR(r.ActionDate) AS ApprovalYear, 
    pt.TECode, 
    COUNT(*) AS ApprovalCount
FROM regactiondate r
JOIN product_tecode pt ON pt.ApplNo = r.ApplNo 
where pt.ProductMktStatus=1 
GROUP BY YEAR(r.ActionDate), pt.TECode
ORDER BY ApprovalYear;

/*SELECT 
    YEAR(r.ActionDate) AS ApprovalYear, 
    pt.TECode, 
    COUNT(*) AS ApprovalCount
FROM regactiondate r
JOIN product pt ON pt.ApplNo = r.ApplNo 
where pt.ProductMktStatus=1 
GROUP BY YEAR(r.ActionDate), pt.TECode
ORDER BY ApprovalYear;*/

/*2. Determine the therapeutic evaluation code (TE_Code) with the highest number of Approvals in 
each year.*/

SELECT
    ApprovalYear,
    TECode,
    ApprovalCount
FROM (
    SELECT
        YEAR(r.ActionDate) AS ApprovalYear,
        pt.TECode,
        COUNT(*) AS ApprovalCount,
        MAX(COUNT(*)) OVER (PARTITION BY YEAR(r.ActionDate)) AS MaxApprovalCount
    FROM product_tecode pt
    JOIN regactiondate r ON pt.ApplNo = r.ApplNo
    where pt.ProductMktStatus=1
    GROUP BY YEAR(r.ActionDate), pt.TECode
) AS Subquery
WHERE ApprovalCount = MaxApprovalCount
ORDER BY ApprovalYear;


/*SELECT
    ApprovalYear,
    TECode,
    ApprovalCount
FROM (
    SELECT
        YEAR(r.ActionDate) AS ApprovalYear,
        pt.TECode,
        COUNT(*) AS ApprovalCount,
        MAX(COUNT(*)) OVER (PARTITION BY YEAR(r.ActionDate)) AS MaxApprovalCount
    FROM product pt
    JOIN regactiondate r ON pt.ApplNo = r.ApplNo
    where pt.ProductMktStatus=1
    GROUP BY YEAR(r.ActionDate), pt.TECode
) AS Subquery
WHERE ApprovalCount = MaxApprovalCount
ORDER BY ApprovalYear;*/

#FINDING STRONGEST ASSOCIATION BETWEEN PRODUCTMKTSTATUS=1 AND DOCTYPE="N", SINCE BOTH OF THEM MEAN APPROVAL STATUS

select count(ProductMktStatus) from product where ProductMktStatus=1;
select count(DocType) from regactiondate where DocType='N';

select p.ProductMktStatus, r.DocType, count(*) as ApprovalCount from product p
join regactiondate r on p.ApplNo=r.ApplNo 
where p.ProductMktStatus=1 and r.DocType='N'
group by p.ProductMktStatus, r.DocType;

select count(ActionType) from regactiondate where ActionType="AP";
select count(DocType) from regactiondate where DocType="N";
select count(ActionType) from application where ActionType="AP";
select count(ActionType) from appdoc where ActionType="AP";
select ap.DocType, ap.ActionType from appdoc ap
join product p on ap.ApplNo=p.ApplNo
where ap.ActionType="AP" and ap.DocType="N";
