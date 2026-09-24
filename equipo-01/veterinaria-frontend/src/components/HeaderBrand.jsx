export default function HeaderBrand() {
  return (
    <div className="form-header-brand">
      <svg className="header-paw-icon" viewBox="0 0 100 100" fill="#1ed0a8">
        <ellipse cx="25" cy="35" rx="9" ry="12" transform="rotate(-20 25 35)" />
        <ellipse cx="42" cy="20" rx="9" ry="12" />
        <ellipse cx="60" cy="20" rx="9" ry="12" />
        <ellipse cx="77" cy="35" rx="9" ry="12" transform="rotate(20 77 35)" />
        <path d="M 25,60 C 20,80 35,92 51,92 C 67,92 82,80 77,60 C 72,45 58,48 51,52 C 44,48 30,45 25,60 Z" />
      </svg>
      <div className="header-brand-text">
        <h2>Ximedgar</h2>
        <span>Clínica veterinaria</span>
      </div>
    </div>
  )
}
