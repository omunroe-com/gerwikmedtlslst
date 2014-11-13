CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[Template:', page_title, ']] -> [[', pl_title, ']]')
FROM pagelinks,
     page
WHERE page_namespace = 10
  AND page_id = pl_from
  AND pl_namespace = 0
  AND pl_title IN
    (SELECT page_title
     FROM pagelinks,
          page
     WHERE page_namespace = 0
       AND page_id = pl_from
       AND page_is_redirect = 1
       AND pl_title IN
         (SELECT page_title
          FROM page_props,
               page
          WHERE pp_page = page_id
            AND page_namespace = 0
            AND pp_propname = 'disambiguation')
     UNION SELECT page_title
     FROM page_props,
          page
     WHERE pp_page = page_id
       AND page_namespace = 0
       AND pp_propname = 'disambiguation')
  AND page_title NOT LIKE '%/man'
ORDER BY page_title;
