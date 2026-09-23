import { useState, useEffect } from 'react'

export default function ArticlesView({ isBookmarked, toggleBookmark }) {
  const [articles, setArticles] = useState([])
  const [selectedArticle, setSelectedArticle] = useState(null)
  const [searchText, setSearchText] = useState('')

  useEffect(() => {
    fetch('/data.json')
      .then(r => r.json())
      .then(data => setArticles(data.articles || []))
  }, [])

  const filtered = articles.filter(a =>
    a.title.toLowerCase().includes(searchText.toLowerCase()) ||
    a.category.toLowerCase().includes(searchText.toLowerCase())
  )

  if (selectedArticle) {
    return (
      <div className="max-w-4xl mx-auto p-4">
        <button
          onClick={() => setSelectedArticle(null)}
          className="mb-4 text-blue-600 dark:text-blue-400"
        >
          ← Volver
        </button>
        <h1 className="text-3xl font-bold mb-4">{selectedArticle.title}</h1>
        <p className="text-gray-600 dark:text-gray-400 mb-4">{selectedArticle.category}</p>
        <div className="prose dark:prose-invert max-w-none">
          <p className="whitespace-pre-wrap">{selectedArticle.content}</p>
        </div>
      </div>
    )
  }

  return (
    <div className="max-w-6xl mx-auto p-4">
      <h1 className="text-3xl font-bold mb-6">Artículos</h1>

      <input
        type="text"
        placeholder="Buscar artículos..."
        value={searchText}
        onChange={(e) => setSearchText(e.target.value)}
        className="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white mb-4"
      />

      <div className="grid gap-4">
        {filtered.map(article => (
          <button
            key={article.id}
            onClick={() => setSelectedArticle(article)}
            className="text-left bg-gray-50 dark:bg-gray-800 rounded-lg p-4 hover:shadow-md transition-shadow"
          >
            <div className="flex items-start justify-between mb-2">
              <div className="bg-blue-200 dark:bg-blue-900 px-2 py-1 rounded text-xs font-bold text-blue-800 dark:text-blue-200">
                {article.category}
              </div>
              <button
                onClick={(e) => {
                  e.stopPropagation()
                  toggleBookmark(article.id, 'article')
                }}
                className="text-xl"
              >
                {isBookmarked(article.id, 'article') ? '🔖' : '📌'}
              </button>
            </div>
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">{article.title}</h3>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-2">{article.content.substring(0, 100)}...</p>
          </button>
        ))}
      </div>
    </div>
  )
}
