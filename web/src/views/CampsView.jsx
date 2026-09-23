import { useState, useEffect } from 'react'
import CampDetailView from './CampDetailView'

export default function CampsView({ isBookmarked, toggleBookmark }) {
  const [camps, setCamps] = useState([])
  const [selectedCamp, setSelectedCamp] = useState(null)
  const [selectedType, setSelectedType] = useState(null)
  const [selectedTerritory, setSelectedTerritory] = useState(null)
  const [searchText, setSearchText] = useState('')

  useEffect(() => {
    fetch('/data.json')
      .then(r => r.json())
      .then(data => {
        if (data.camps) {
          setCamps(data.camps.sort((a, b) => a.name.localeCompare(b.name)))
        }
      })
  }, [])

  const filteredCamps = camps.filter(camp => {
    const matchesType = !selectedType || camp.type === selectedType
    const matchesTerritory = !selectedTerritory || camp.territory === selectedTerritory
    const matchesSearch = !searchText ||
      camp.name.toLowerCase().includes(searchText.toLowerCase()) ||
      camp.location.toLowerCase().includes(searchText.toLowerCase())
    return matchesType && matchesTerritory && matchesSearch
  })

  const types = Array.from(new Set(camps.map(c => c.type))).sort()
  const territories = Array.from(new Set(camps.map(c => c.territory))).sort()

  const typeColors = {
    'Campo de Concentración': '#FF9500',
    'Campo de Exterminio': '#FF3B30',
    'Campo de Trabajo Forzado': '#FFA500',
    'Campo de Tránsito': '#FFCC00',
  }

  if (selectedCamp) {
    return (
      <CampDetailView
        camp={selectedCamp}
        onBack={() => setSelectedCamp(null)}
        isBookmarked={isBookmarked}
        toggleBookmark={toggleBookmark}
      />
    )
  }

  return (
    <div className="max-w-6xl mx-auto p-4">
      <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-6">Campos</h1>

      {/* Search */}
      <div className="mb-4">
        <input
          type="text"
          placeholder="Buscar camps..."
          value={searchText}
          onChange={(e) => setSearchText(e.target.value)}
          className="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white"
        />
      </div>

      {/* Type Filter */}
      {types.length > 0 && (
        <div className="mb-4">
          <div className="flex flex-wrap gap-2 mb-2">
            {selectedType && (
              <button
                onClick={() => setSelectedType(null)}
                className="px-3 py-1 bg-gray-300 dark:bg-gray-600 text-gray-800 dark:text-white rounded-full text-sm font-medium"
              >
                Todos
              </button>
            )}
            {types.map(type => (
              <button
                key={type}
                onClick={() => setSelectedType(type)}
                className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
                  selectedType === type
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white hover:bg-gray-300 dark:hover:bg-gray-600'
                }`}
              >
                {type}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* Territory Filter */}
      {territories.length > 0 && (
        <div className="mb-6">
          <div className="flex flex-wrap gap-2 mb-2">
            {selectedTerritory && (
              <button
                onClick={() => setSelectedTerritory(null)}
                className="px-3 py-1 bg-gray-300 dark:bg-gray-600 text-gray-800 dark:text-white rounded-full text-sm font-medium"
              >
                Todos
              </button>
            )}
            {territories.map(territory => (
              <button
                key={territory}
                onClick={() => setSelectedTerritory(territory)}
                className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
                  selectedTerritory === territory
                    ? 'bg-green-600 text-white'
                    : 'bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white hover:bg-gray-300 dark:hover:bg-gray-600'
                }`}
              >
                {territory}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* Camps List */}
      {filteredCamps.length === 0 ? (
        <div className="text-center py-8">
          <p className="text-gray-600 dark:text-gray-400">No hay campos disponibles</p>
        </div>
      ) : (
        <div className="grid gap-4">
          {filteredCamps.map(camp => (
            <button
              key={camp.id}
              onClick={() => setSelectedCamp(camp)}
              className="text-left bg-gray-50 dark:bg-gray-800 rounded-lg p-4 hover:shadow-md transition-shadow"
            >
              <div className="flex items-start justify-between mb-2">
                <div
                  className="px-2 py-1 rounded text-white text-xs font-bold"
                  style={{ backgroundColor: typeColors[camp.type] }}
                >
                  {camp.type}
                </div>
              </div>
              <h3 className="text-lg font-bold text-gray-900 dark:text-white mb-2">{camp.name}</h3>
              <div className="space-y-1 text-sm text-gray-600 dark:text-gray-400">
                <p>📍 {camp.territory} - {camp.location}</p>
                <p>📅 Establecido: {camp.established}</p>
                {camp.liberated && <p>📅 Liberado: {camp.liberated}</p>}
                {camp.totalDeaths && (
                  <p className="text-red-600 dark:text-red-400 font-semibold">⚠️ {camp.totalDeaths.toLocaleString()} vidas perdidas</p>
                )}
              </div>
            </button>
          ))}
        </div>
      )}
    </div>
  )
}
