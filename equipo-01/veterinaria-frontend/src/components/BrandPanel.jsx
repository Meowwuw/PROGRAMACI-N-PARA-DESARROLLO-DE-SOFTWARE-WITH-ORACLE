export default function BrandPanel() {
  return (
    <div className="left-panel">
      <div className="logo-oval-container">
        <svg className="brand-paw-icon" viewBox="0 0 200 180" xmlns="http://www.w3.org/2000/svg">
          <ellipse cx="40" cy="70" rx="18" ry="24" transform="rotate(-25 40 70)" fill="#1ed0a8" />
          <ellipse cx="80" cy="35" rx="18" ry="25" transform="rotate(-8 80 35)" fill="#1ed0a8" />
          <ellipse cx="125" cy="35" rx="18" ry="25" transform="rotate(8 125 35)" fill="#1ed0a8" />
          <ellipse cx="165" cy="70" rx="18" ry="24" transform="rotate(25 165 70)" fill="#1ed0a8" />

          <g transform="translate(10, 30)">
            <path
              d="M 40,75 C 30,105 50,140 92,140 C 135,140 155,105 145,75 C 135,50 115,55 92,62 C 70,55 50,50 40,75 Z"
              fill="#1ed0a8"
            />
            <path d="M 52,120 C 50,90 68,75 78,85 C 83,90 85,100 82,120 Z" fill="#ffffff" />
            <polygon points="56,76 66,80 58,90" fill="#ffffff" />
            <polygon points="76,80 84,75 80,88" fill="#ffffff" />
            <circle cx="68" cy="98" r="2" fill="#1ed0a8" />
            <path d="M 64,103 Q 68,107 72,103" stroke="#1ed0a8" strokeWidth="1.8" fill="none" strokeLinecap="round" />

            <path
              d="M 100,120 C 95,95 105,75 125,75 C 135,75 140,88 138,120 Z"
              fill="#e6c875"
            />
            <path d="M 125,75 C 138,70 145,85 138,95 C 132,95 126,85 125,75 Z" fill="#cfa846" />
            <circle cx="116" cy="92" r="2.2" fill="#333" />
            <ellipse cx="110" cy="98" rx="3.5" ry="2.5" fill="#333" />
          </g>

          <path
            d="M 92,118 C 92,118 86,112 86,108 C 86,105 88,103 90.5,103 C 92,103 92,105 92,105 C 92,105 92,103 93.5,103 C 96,103 98,105 98,108 C 98,112 92,118 92,118 Z"
            fill="#ff5b5b"
          />
        </svg>

        <div className="brand-title-primary">Ximedgar</div>
        <div className="brand-title-secondary">HUELLITAS</div>
      </div>

      <p className="brand-slogan">El hogar donde sus huellas son nuestro mundo.</p>
    </div>
  )
}
