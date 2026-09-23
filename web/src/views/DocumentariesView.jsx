import { useState, useEffect } from 'react'

export default function DocumentariesView({ isBookmarked, toggleBookmark }) {
  const [documentaries, setDocumentaries] = useState([])

  useEffect(() => {
    fetch('/data.json')
      .then(r => r.json())
      .then(data => setDocumentaries(data.documentaries || []))
  }, [])

  return (
    <div className="max-w-6xl mx-auto p-4">
      <h1 className="text-3xl font-bold mb-6">Documentales</h1>
      <div className="grid gap-4">
        {documentaries.map(doc => (
          <div key={doc.id} className="bg-gray-50 dark:bg-gray-800 rounded-lg p-4">
            <div className="flex justify-between items-start mb-2">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">{doc.title}</h3>
              <button onClick={() => toggleBookmark(doc.id, 'documentary')} className="text-xl">
                {isBookmarked(doc.id, 'documentary') ? '🔖' : '📌'}
              </button>
            </div>
            <p className="text-sm text-gray-600 dark:text-gray-400">{doc.type}</p>
          </div>
        ))}
      </div>
    </div>
  )
}
