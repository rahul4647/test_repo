export async function GET() {
  return NextResponse.json({ status: 'ok', uptime: process.uptime(), timestamp: Date.now() }, { status: 200 });
}