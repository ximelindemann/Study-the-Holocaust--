import { useState, useEffect } from 'react'

export default function ProfilesView({ isBookmarked, toggleBookmark }) {
  const [profiles, setProfiles] = useState([])

  useEffect(() => {
    fetch('/data.json')
      .then(r => r.json())
      .then(data => setProfiles(data.profiles || []))
  }, [])

  return (
    <div className="max-w-6xl mx-auto p-4">
      <h1 className="text-3xl font-bold mb-6">Perfiles Históricos</h1>
      <div className="grid gap-4">
        {profiles.map(profile => (
          <div key={profile.id} className="bg-gray-50 dark:bg-gray-800 rounded-lg p-4">
            <div className="flex justify-between items-start mb-2">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">{profile.name}</h3>
              <button onClick={() => toggleBookmark(profile.id, 'profile')} className="text-xl">
                {isBookmarked(profile.id, 'profile') ? '🔖' : '📌'}
              </button>
            </div>
            <p className="text-sm text-gray-600 dark:text-gray-400">{profile.profileType}</p>
            {profile.birthDate && <p className="text-xs text-gray-500">{profile.birthDate}</p>}
          </div>
        ))}
      </div>
    </div>
  )
}
