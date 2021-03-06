USE [master]
GO
/****** Object:  Database [VisionClinic]    Script Date: 17.11.2016 14:35:50 ******/
CREATE DATABASE [VisionClinic]
 CONTAINMENT = NONE
GO

USE [VisionClinic]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 17.11.2016 14:35:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentTime] [datetime] NOT NULL,
	[AppointmentDate] [datetime] NOT NULL,
	[AppointmentType] [smallint] NOT NULL,
	[DoctorNotes] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[Created] [datetimeoffset](7) NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[Modified] [datetimeoffset](7) NULL,
	[RowVersion] [timestamp] NOT NULL,
	[Appointment_Patient] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 17.11.2016 14:35:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Product_ProductID] [int] NOT NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[Created] [datetimeoffset](7) NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[Modified] [datetimeoffset](7) NULL,
	[RowVersion] [timestamp] NOT NULL,
	[Invoice_InvoiceDetail] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 17.11.2016 14:35:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[InvoiceDue] [datetime] NOT NULL,
	[InvoiceStatus] [int] NOT NULL,
	[ShipDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[Created] [datetimeoffset](7) NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[Modified] [datetimeoffset](7) NULL,
	[RowVersion] [timestamp] NOT NULL,
	[Invoice_Patient] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patients]    Script Date: 17.11.2016 14:35:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Street] [nvarchar](255) NOT NULL,
	[Street2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NOT NULL,
	[State] [nvarchar](255) NOT NULL,
	[Zip] [nvarchar](255) NOT NULL,
	[PrimaryPhone] [nvarchar](255) NOT NULL,
	[SecondaryPhone] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[PolicyNumber] [nvarchar](12) NOT NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[Created] [datetimeoffset](7) NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[Modified] [datetimeoffset](7) NULL,
	[RowVersion] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 17.11.2016 14:35:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[MSRP] [money] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ProductImage] [varbinary](max) NULL,
	[Category] [nvarchar](max) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[ProductRebate]    Script Date: 17.11.2016 14:35:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductRebate](
	[ProductRebateID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[RebateStart] [smalldatetime] NULL,
	[RebateEnd] [smalldatetime] NULL,
	[Rebate] [money] NULL,
 CONSTRAINT [PK_ProductRebate] PRIMARY KEY CLUSTERED 
(
	[ProductRebateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT (getdate()) FOR [AppointmentTime]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT (getdate()) FOR [AppointmentDate]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT ((0)) FOR [AppointmentType]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT ((0)) FOR [Appointment_Patient]
GO
ALTER TABLE [dbo].[InvoiceDetails] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[InvoiceDetails] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[InvoiceDetails] ADD  DEFAULT ((0)) FOR [Product_ProductID]
GO
ALTER TABLE [dbo].[InvoiceDetails] ADD  DEFAULT ((0)) FOR [Invoice_InvoiceDetail]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [InvoiceDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [InvoiceDue]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [InvoiceStatus]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [ShipDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [Invoice_Patient]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ('') FOR [Street]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ('') FOR [City]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ('') FOR [State]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ('') FOR [Zip]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ('') FOR [PrimaryPhone]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ('') FOR [PolicyNumber]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [Appointment_Patient] FOREIGN KEY([Appointment_Patient])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [Invoice_InvoiceDetail] FOREIGN KEY([Invoice_InvoiceDetail])
REFERENCES [dbo].[Invoices] ([Id])
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [Product_InvoiceDetail] FOREIGN KEY([Product_ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [Invoice_Patient] FOREIGN KEY([Invoice_Patient])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[ProductRebate]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductRebate] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
USE [master]
GO
ALTER DATABASE [VisionClinic] SET  READ_WRITE 
GO
