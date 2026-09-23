import { useState, useEffect } from 'react'
import HomeView from './views/HomeView'
import ArticlesView from './views/ArticlesView'
import DocumentariesView from './views/DocumentariesView'
import ProfilesView from './views/ProfilesView'
import PerpetratorListView from './views/PerpetratorListView'
import LegislationView from './views/LegislationView'
import MapView from './views/MapView'
import TimelineView from './views/TimelineView'
import CampsView from './views/CampsView'
import QuizView from './views/QuizView'
import StatisticsView from './views/StatisticsView'
import BookmarksView from './views/BookmarksView'
import SearchView from './views/SearchView'

export default function App() {
  const [selectedTab, setSelectedTab] = useState(0)
  const [bookmarks, setBookmarks] = useState([])

  useEffect(() => {
    const saved = localStorage.getItem('bookmarks')
    if (saved) setBookmarks(JSON.parse(saved))
  }, [])

  const toggleBookmark = (itemId, itemType) => {
    setBookmarks(prev => {
      const newBookmarks = prev.some(b => b.itemId === itemId && b.itemType === itemType)
        ? prev.filter(b => !(b.itemId === itemId && b.itemType === itemType))
        : [...prev, { itemId, itemType }]
      localStorage.setItem('bookmarks', JSON.stringify(newBookmarks))
      return newBookmarks
    })
  }

  const isBookmarked = (itemId, itemType) =>
    bookmarks.some(b => b.itemId === itemId && b.itemType === itemType)

  const views = [
    { label: 'Inicio', icon: '🏠', component: HomeView },
    { label: 'Artículos', icon: '📚', component: ArticlesView },
    { label: 'Documentales', icon: '🎬', component: DocumentariesView },
    { label: 'Perfiles', icon: '👤', component: ProfilesView },
    { label: 'Perpetradores', icon: '⚠️', component: PerpetratorListView },
    { label: 'Legislación', icon: '📋', component: LegislationView },
    { label: 'Mapa', icon: '🗺️', component: MapView },
    { label: 'Timeline', icon: '⏱️', component: TimelineView },
    { label: 'Campos', icon: '🏢', component: CampsView },
    { label: 'Quiz', icon: '🧠', component: QuizView },
    { label: 'Estadísticas', icon: '📊', component: StatisticsView },
    { label: 'Marcadores', icon: '🔖', component: BookmarksView },
    { label: 'Buscar', icon: '🔍', component: SearchView },
  ]

  const CurrentView = views[selectedTab].component

  return (
    <div className="flex flex-col h-screen bg-white dark:bg-gray-900">
      {/* Main Content */}
      <div className="flex-1 overflow-y-auto">
        <CurrentView
          bookmarks={bookmarks}
          toggleBookmark={toggleBookmark}
          isBookmarked={isBookmarked}
        />
      </div>

      {/* Tab Navigation */}
      <div className="border-t border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 overflow-x-auto">
        <div className="flex justify-between min-w-max md:justify-start">
          {views.map((view, index) => (
            <button
              key={index}
              onClick={() => setSelectedTab(index)}
              className={`flex flex-col items-center justify-center px-3 py-3 text-xs font-medium transition-colors whitespace-nowrap ${
                selectedTab === index
                  ? 'text-blue-600 dark:text-blue-400 border-b-2 border-blue-600 dark:border-blue-400'
                  : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-200'
              }`}
            >
              <span className="text-lg mb-0.5">{view.icon}</span>
              <span className="hidden sm:inline">{view.label}</span>
            </button>
          ))}
        </div>
      </div>
    </div>
  )
}
