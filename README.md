# KarUCU Main Campus - Next.js Application

A standalone Next.js application for Karatina University Christian Union Main Campus website with server-side rendering.

## Features

- ✅ Server-side rendering (SSR) for optimal performance
- ✅ MySQL database integration
- ✅ API routes for data fetching
- ✅ Responsive design with Tailwind CSS
- ✅ Leadership directory
- ✅ Blog and testimonies
- ✅ Events management
- ✅ Media gallery with external links
- ✅ Authentication system

## Tech Stack

- **Framework**: Next.js 14 (App Router)
- **Database**: MySQL
- **Styling**: Tailwind CSS
- **Authentication**: JWT with bcrypt
- **Icons**: Font Awesome

## Prerequisites

- Node.js 18+ 
- MySQL 8+
- npm or yarn

## Installation

1. **Clone and navigate to the project**
   ```bash
   cd nextjs-app
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**
   
   Create a `.env.local` file in the root directory:
   ```env
   # Database Configuration
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=karucu_database
   DB_PORT=3306

   # JWT Secret
   JWT_SECRET=your_super_secret_jwt_key_here_change_in_production

   # App Configuration
   NEXT_PUBLIC_API_URL=http://localhost:3000
   ```

4. **Set up the database**
   
   Import the database schema from the server folder:
   ```bash
   mysql -u root -p karucu_database < ../server/database/karucu_database.sql
   ```

5. **Run the development server**
   ```bash
   npm run dev
   ```

6. **Open your browser**
   
   Navigate to [http://localhost:3000](http://localhost:3000)

## Project Structure

```
nextjs-app/
├── src/
│   ├── app/                    # App router pages
│   │   ├── api/               # API routes
│   │   │   ├── auth/          # Authentication endpoints
│   │   │   ├── blogs/         # Blog endpoints
│   │   │   ├── events/        # Events endpoints
│   │   │   ├── gallery/       # Gallery endpoints
│   │   │   └── leaders/       # Leaders endpoints
│   │   ├── about/             # About page
│   │   ├── blog/              # Blog page
│   │   ├── events/            # Events page
│   │   ├── leadership/        # Leadership page
│   │   ├── media/             # Media gallery page
│   │   ├── layout.jsx         # Root layout
│   │   ├── page.jsx           # Home page
│   │   └── globals.css        # Global styles
│   ├── components/            # Reusable components
│   │   ├── Navigation.jsx     # Navigation bar
│   │   └── Footer.jsx         # Footer
│   └── lib/                   # Utility functions
│       ├── db.js              # Database connection
│       └── auth.js            # Authentication utilities
├── public/                    # Static files
├── .env.local                 # Environment variables
├── next.config.js             # Next.js configuration
├── tailwind.config.js         # Tailwind configuration
└── package.json               # Dependencies

```

## Key Features Explained

### Server-Side Rendering (SSR)

All main pages use SSR to fetch data at build/request time:
- Leadership page fetches active leaders from database
- Blog page fetches approved blog posts
- Events page fetches upcoming events
- Media page fetches gallery links

### Client Components

Interactive features are isolated in client components:
- `LeadershipClient.jsx` - Modal interactions
- `BlogClient.jsx` - Post filtering and modals
- `EventsClient.jsx` - Event filtering and registration
- `MediaClient.jsx` - Gallery category filtering
- `Navigation.jsx` - Mobile menu toggle

### API Routes

RESTful API endpoints in `/api`:
- `GET /api/leaders` - Fetch leaders
- `GET /api/blogs` - Fetch blog posts
- `GET /api/events` - Fetch events
- `GET /api/gallery` - Fetch gallery links
- `POST /api/auth/login` - User authentication

## Database Tables

The application uses these main tables:
- `leaders` - Leadership information
- `blogs` - Blog posts and testimonies
- `events` - Upcoming events
- `galleries` - External gallery links
- `users` - User accounts

## Building for Production

```bash
# Build the application
npm run build

# Start production server
npm start
```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `DB_HOST` | MySQL host | Yes |
| `DB_USER` | MySQL username | Yes |
| `DB_PASSWORD` | MySQL password | Yes |
| `DB_NAME` | Database name | Yes |
| `DB_PORT` | MySQL port | Yes |
| `JWT_SECRET` | Secret for JWT tokens | Yes |
| `NEXT_PUBLIC_API_URL` | Public API URL | Yes |

## Deployment

### Vercel (Recommended)

1. Push your code to GitHub
2. Import project in Vercel
3. Add environment variables
4. Deploy

### Other Platforms

The app can be deployed to any platform supporting Node.js:
- Railway
- Render
- DigitalOcean App Platform
- AWS Amplify

## License

© 2024 KarUCU Main Campus. All rights reserved.
