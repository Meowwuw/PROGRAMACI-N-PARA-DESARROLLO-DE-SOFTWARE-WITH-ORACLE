import { Search } from 'lucide-react'

export default function TopBar() {
  return (
    <header className="topbar">
      <div className="topbar-search">
        <Search size={18} strokeWidth={2} />
        <input type="text" placeholder="Buscar dueños, mascotas..." />
      </div>
    </header>
  )
}
