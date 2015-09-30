SELECT TOP 10 t.TagName
INTO #TopTags
FROM Tags t ORDER BY t.Count DESC

SELECT
    CAST(p.CreationDate AS date) AS post_date,
    COUNT(*) AS posts_per_day,
    SUM(p.ViewCount) AS views_per_day,
    SUM(p.AnswerCount) AS answers_per_day,
    SUM(p.CommentCount) AS comments_per_day,
    SUM(p.FavoriteCount) AS favorites_per_day,
    SUM(p.Score) AS score_per_day,
    t.TagName AS tag_name
    FROM Tags t
    JOIN PostTags AS pt ON t.Id = pt.TagId
    JOIN Posts AS p ON pt.PostId = p.Id
    WHERE t.TagName IN (SELECT * FROM #TopTags)
    GROUP BY CAST(p.CreationDate AS date), t.TagName
    ORDER BY post_date DESC