export default function HomeView() {
  return (
    <div className="max-w-4xl mx-auto p-4">
      <div className="text-center py-8">
        <h1 className="text-4xl font-bold text-gray-900 dark:text-white mb-4">
          Estudiando el Holocausto
        </h1>
        <p className="text-gray-600 dark:text-gray-300 text-lg mb-8">
          Una aplicación educativa comprensiva sobre la Segunda Guerra Mundial y el Holocausto
        </p>
      </div>

      <div className="grid md:grid-cols-2 gap-6">
        <div className="bg-blue-50 dark:bg-blue-900 rounded-lg p-6">
          <h2 className="text-xl font-bold text-blue-900 dark:text-blue-100 mb-3">📚 Educación</h2>
          <p className="text-blue-800 dark:text-blue-200">
            Accede a artículos, documentales, y perfiles históricos detallados sobre el Holocausto.
          </p>
        </div>

        <div className="bg-green-50 dark:bg-green-900 rounded-lg p-6">
          <h2 className="text-xl font-bold text-green-900 dark:text-green-100 mb-3">🏢 Campos</h2>
          <p className="text-green-800 dark:text-green-200">
            Explora la geografía de los campos de concentración y exterminio en todos los territorios ocupados.
          </p>
        </div>

        <div className="bg-purple-50 dark:bg-purple-900 rounded-lg p-6">
          <h2 className="text-xl font-bold text-purple-900 dark:text-purple-100 mb-3">📊 Estadísticas</h2>
          <p className="text-purple-800 dark:text-purple-200">
            Datos y análisis sobre los perpetradores, víctimas, y alcance del Holocausto.
          </p>
        </div>

        <div className="bg-orange-50 dark:bg-orange-900 rounded-lg p-6">
          <h2 className="text-xl font-bold text-orange-900 dark:text-orange-100 mb-3">⏱️ Timeline</h2>
          <p className="text-orange-800 dark:text-orange-200">
            Una línea de tiempo detallada de eventos clave durante la Segunda Guerra Mundial.
          </p>
        </div>
      </div>

      <div className="mt-8 bg-gray-100 dark:bg-gray-800 rounded-lg p-6">
        <h2 className="text-xl font-bold text-gray-900 dark:text-white mb-4">Acerca de esta aplicación</h2>
        <p className="text-gray-700 dark:text-gray-300 mb-4">
          Esta aplicación ha sido desarrollada como una herramienta educativa integral para comprender uno de los eventos más significativos de la historia humana.
        </p>
        <p className="text-gray-700 dark:text-gray-300">
          Contiene información sobre perpetradores, víctimas, sobrevivientes, rescatadores, campos de concentración y exterminio, documentación legal, y una línea de tiempo detallada.
        </p>
      </div>
    </div>
  )
}
