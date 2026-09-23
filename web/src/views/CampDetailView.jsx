export default function CampDetailView({ camp, onBack, isBookmarked, toggleBookmark }) {
  const typeColors = {
    'Campo de Concentración': '#FF9500',
    'Campo de Exterminio': '#FF3B30',
    'Campo de Trabajo Forzado': '#FFA500',
    'Campo de Tránsito': '#FFCC00',
  }

  const bookmarkIcon = isBookmarked(camp.id, 'camp') ? '🔖' : '📌'

  return (
    <div className="max-w-4xl mx-auto p-4">
      {/* Header */}
      <div className="mb-6">
        <button
          onClick={onBack}
          className="mb-4 text-blue-600 dark:text-blue-400 hover:text-blue-800"
        >
          ← Volver
        </button>

        <div className="text-center">
          <div
            className="inline-block w-24 h-24 rounded-full flex items-center justify-center text-4xl mb-4"
            style={{ backgroundColor: typeColors[camp.type] + '30' }}
          >
            🏢
          </div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{camp.name}</h1>
          <div
            className="inline-block px-3 py-1 rounded text-white text-sm font-bold"
            style={{ backgroundColor: typeColors[camp.type] }}
          >
            {camp.type}
          </div>

          <button
            onClick={() => toggleBookmark(camp.id, 'camp')}
            className="ml-2 text-xl hover:scale-110 transition-transform"
          >
            {bookmarkIcon}
          </button>
        </div>
      </div>

      {/* Location */}
      <div className="bg-gray-50 dark:bg-gray-800 rounded-lg p-4 mb-4">
        <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-3">Ubicación</h2>
        <div className="space-y-2 text-sm">
          <p><span className="text-gray-600 dark:text-gray-400">Territorio:</span> <span className="font-semibold text-gray-900 dark:text-white">{camp.territory}</span></p>
          <p><span className="text-gray-600 dark:text-gray-400">Ubicación:</span> <span className="font-semibold text-gray-900 dark:text-white">{camp.location}</span></p>
          <p><span className="text-gray-600 dark:text-gray-400">Establecido:</span> <span className="font-semibold text-gray-900 dark:text-white">{camp.established}</span></p>
          {camp.liberated && (
            <p><span className="text-gray-600 dark:text-gray-400">Liberado:</span> <span className="font-semibold text-gray-900 dark:text-white">{camp.liberated}</span></p>
          )}
        </div>
      </div>

      {/* Casualties */}
      <div className="bg-red-50 dark:bg-red-900/20 rounded-lg p-4 mb-4">
        <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-3">Víctimas</h2>
        <div className="space-y-2 text-sm">
          <p><span className="text-gray-600 dark:text-gray-400">Estimado:</span> <span className="font-semibold text-red-600 dark:text-red-400">{camp.estimatedCasualties}</span></p>
          {camp.totalDeaths && (
            <p><span className="text-gray-600 dark:text-gray-400">Documentado:</span> <span className="font-semibold text-red-600 dark:text-red-400">{camp.totalDeaths.toLocaleString()}</span></p>
          )}
        </div>
      </div>

      {/* Description */}
      <div className="bg-gray-50 dark:bg-gray-800 rounded-lg p-4 mb-4">
        <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-3">Descripción</h2>
        <p className="text-gray-700 dark:text-gray-300 leading-relaxed">{camp.description}</p>
      </div>

      {/* Historical Significance */}
      <div className="bg-blue-50 dark:bg-blue-900/20 rounded-lg p-4 mb-4">
        <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-3">Significancia Histórica</h2>
        <p className="text-gray-700 dark:text-gray-300 leading-relaxed">{camp.historicalSignificance}</p>
      </div>

      {/* Operators */}
      {camp.operators && camp.operators.length > 0 && (
        <div className="bg-gray-50 dark:bg-gray-800 rounded-lg p-4 mb-4">
          <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-3">Operadores</h2>
          <ul className="space-y-1 text-sm text-gray-700 dark:text-gray-300">
            {camp.operators.map((op, i) => (
              <li key={i}>• {op}</li>
            ))}
          </ul>
        </div>
      )}

      {/* Sources */}
      {camp.sources && camp.sources.length > 0 && (
        <div className="bg-gray-50 dark:bg-gray-800 rounded-lg p-4 mb-4">
          <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-3">Fuentes</h2>
          <ul className="space-y-1 text-sm text-gray-700 dark:text-gray-300">
            {camp.sources.map((source, i) => (
              <li key={i}>📄 {source}</li>
            ))}
          </ul>
        </div>
      )}
    </div>
  )
}
