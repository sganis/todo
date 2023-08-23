import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
async function main() {
	await prisma.roomType.de.deleteMany();
	const roomtypes = await prisma.roomType.createMany({
		data: [
			{
				name: 'DOUBLE',
				num_guests: 2
			},
			{
				name: 'TRIPLE',
				num_guests: 3
			},
			{
				name: 'QUADRUPLE',
				num_guests: 4
			}
		]
	});
	console.log(roomtypes);
}

main()
	.then(async () => {
		await prisma.$disconnect();
	})
	.catch(async (e) => {
		console.error(e);
		await prisma.$disconnect();
		process.exit(1);
	});
